//
//  VehiclesListingViewModel.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import RxSwift
import RxCocoa

enum VehicleTableViewCellType {
    case normal(cellViewModel: VehicleCellViewModel)
    case error(message: String)
    case empty
}

class VehiclesTableViewModel {
    
    let cells = BehaviorRelay<[VehicleTableViewCellType]>(value: [])
    private let disposeBag = DisposeBag()
    private let apiProvider: APIProvider
    let showLoadingIndicator = BehaviorRelay(value: false)
    let showRefreshControl = BehaviorRelay(value: false)
    
    // Hamburg Bounds by default
    static var bounds = LocationBounds(point1Long: 53.694865, point1Lat: 9.757589, point2Long: 53.394655, point2Lat: 10.099891)
    
    init(myAPI: MyTaxiAPI = RealAPI()) {
        apiProvider = APIProvider(apiProvider: myAPI)
    }
    
    func fetchNearbyVehicles(withingBounds bounds: LocationBounds = bounds,andShowLoadingIndicator showIndicator: Bool = true) {
        
        if showIndicator {
            showLoadingIndicator.accept(true)
        }
        
        apiProvider.fetchVehicles(withinBounds: bounds, success: { [weak self] response in
            
            if showIndicator {
                self?.showLoadingIndicator.accept(false)
            }else{
                self?.showRefreshControl.accept(false)
            }
            
            guard let responseModel = (response as? Vehicles), responseModel.vehicles.count > 0 else {
                self?.cells.accept([.empty])
                return
            }
            
            self?.cells.accept(responseModel.vehicles.compactMap {
                .normal(cellViewModel: VehicleCellViewModel(vehicle: $0))
            })
            
        }, failure: { [weak self] error in
            if showIndicator {
                self?.showLoadingIndicator.accept(false)
            }else{
                self?.showRefreshControl.accept(false)
            }
            let message = getErrorMessage(error: error)
            self?.cells.accept([.error(message: message)])
            
        })
    }
    
}
