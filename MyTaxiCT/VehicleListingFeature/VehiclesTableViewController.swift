//
//  VehiclesTableViewController.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit
import RxSwift
import PKHUD

class VehiclesTableViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var vehiclesTableView: UITableView!
    
    // MARK: Attributes
    var vehiclesViewModel: VehiclesTableViewModel = VehiclesTableViewModel()
    lazy var refreshControl = UIRefreshControl()
    let disposeBag = DisposeBag()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        bindViewModel()
        vehiclesViewModel.fetchNearbyVehicles()
        setUpRefreshControl()

    }
    
    func setUpTableView(){
        let vehicleCellNib = UINib.init(nibName: VehicleTableViewCell.reusableIdentifier, bundle: nil)
        vehiclesTableView.register(vehicleCellNib, forCellReuseIdentifier: VehicleTableViewCell.reusableIdentifier)
        vehiclesTableView.estimatedRowHeight = 150
        vehiclesTableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindViewModel(){

        vehiclesViewModel.cells.bind(to: vehiclesTableView.rx.items) { [weak self] (tableView, index, element) in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .normal(let viewModel):
        
                guard let cell = self?.vehiclesTableView.dequeueReusableCell(withIdentifier: VehicleTableViewCell.reusableIdentifier, for: indexPath) as? VehicleTableViewCell else {
                    return UITableViewCell()
                }
                cell.configureCell(withViewModel: viewModel, andCompletion: { [weak self] in
                    self?.layoutTableView(withRow: index)
                })
                
                return cell
                
            case .error(let message):
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = message
                return cell
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = "No data available"
                return cell
            }
            }.disposed(by: disposeBag)
        
        vehiclesViewModel.showLoadingIndicator.asObservable().distinctUntilChanged()
            .map { [weak self] in
                self?.setLoadingIndicator(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        vehiclesViewModel.showRefreshControl.asObservable()
            .filter {
                $0 == false
            }.map { [weak self] _ in
                self?.refreshControl.endRefreshing()
            }.subscribe()
            .disposed(by: disposeBag)
    }
    
    func layoutTableView(withRow row: Int) {
        let index = IndexPath.init(row: row, section: 0)
        self.vehiclesTableView.reloadRows(at: [index], with: .none)
    }
    
    private func setLoadingIndicator(visible: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        visible ? PKHUD.sharedHUD.show(onView: view) : PKHUD.sharedHUD.hide()
    }
    
    func setUpRefreshControl(){
        refreshControl.addTarget(self, action: #selector(didRefresh), for: UIControl.Event.valueChanged)
        vehiclesTableView.refreshControl = refreshControl
    }
    
    @objc
    func didRefresh(){
        vehiclesViewModel.fetchNearbyVehicles(andShowLoadingIndicator: false)
    }

}

