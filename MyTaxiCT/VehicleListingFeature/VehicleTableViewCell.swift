//
//  VehicleTableViewCell.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit
import RxSwift

typealias completion = (()->(Void))?

class VehicleTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "VehicleTableViewCell"
    
    let disposeBag = DisposeBag()
    var completion: completion
    
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var fleetTypeLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.black
        headingLabel.textColor = .white
        fleetTypeLabel.textColor = .yellow
    }
    
    var viewModel: VehicleCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            fleetTypeLabel?.text = viewModel.fleetType
        }
    }
    
    func configureCell(withViewModel viewModel: VehicleCellViewModel, andCompletion completion: completion) {
        
        self.viewModel = viewModel
        self.completion = completion
        self.viewModel?.address.asObservable().filter{
            !$0.isEmpty
            }.subscribe(onNext: { [weak self] value in
                self?.headingLabel.text = value
                self?.completion?()
            }).disposed(by: disposeBag)
    }

}
