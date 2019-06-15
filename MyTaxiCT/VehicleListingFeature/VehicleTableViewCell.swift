//
//  VehicleTableViewCell.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit
import RxSwift

class VehicleTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "VehicleTableViewCell"
    
    let disposeBag = DisposeBag()
    
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

}
