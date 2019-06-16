//
//  VehicleCellViewModel.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
import CoreLocation
import RxCocoa

class VehicleCellViewModel: NSObject {
    var fleetType: String = ""
    var heading: String = ""
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    let address = BehaviorRelay<String>(value: "Vehicle address: ... ")
    
    init(vehicle: VehicleObjc) {
        super.init()
        
        self.fleetType = "Fleet Type: \(vehicle.fleetType ?? "")"
        self.heading = "Heading: \(vehicle.heading ?? 0)"
        self.longitude = vehicle.coordinate?.longitude ?? 0
        self.latitude = vehicle.coordinate?.latitude ?? 0
        let location = CLLocation.init(latitude: self.latitude, longitude: self.longitude)
        getVehicleAddress(fromLocation: location)
    }
}


// MARK: Vahicle location address
extension VehicleCellViewModel: CLLocationManagerDelegate {
  
    func getFormattedAddress(withPlacemarkes placemarkes: CLPlacemark) -> String{
        var emptyAddress = false
        if (placemarkes.thoroughfare?.isEmpty ?? true) && (placemarkes.postalCode?.isEmpty ?? true) && (placemarkes.postalCode?.isEmpty ?? true) && (placemarkes.postalCode?.isEmpty ?? true) {
            emptyAddress = true
        }
        
        //Default value
        var textAddress = placemarkes.name
        
        if !emptyAddress {
            textAddress = "\(placemarkes.thoroughfare  ?? "-")\n\(placemarkes.postalCode ?? "-") \(placemarkes.locality ?? "-"  )\n\(placemarkes.country ?? "-")"
        }
        
        return "Vehicle address: \((textAddress?.isEmpty ?? true) ? "Not available" : textAddress!)"
    }
    
    func getVehicleAddress(fromLocation location: CLLocation) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarkes, error) in
            if let placemark = placemarkes?.last, error == nil  {
                self?.address.accept(self?.getFormattedAddress(withPlacemarkes: placemark) ?? "Vehicle address: Not available")
            }else{
                self?.address.accept("Vehicle address: Not available")
            }
        }
    }
}
