//
//  NearbyVehiclesViewController.m
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NearbyVehiclesViewController.h"
#import "MyTaxiCT-Swift.h"


@implementation NearbyVehiclesViewController
    
    - (void)viewDidLoad{
        [super viewDidLoad];
        [self navigationController].navigationBar.hidden = true;
    }

@end



//// MARK: My Location
//extension VehiclesTableViewController: CLLocationManagerDelegate {
//
//    func setUpMyLocation(){
//        // Ask for Authorisation from the User.
//        self.locationManager.requestAlwaysAuthorization()
//
//        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }
//}
