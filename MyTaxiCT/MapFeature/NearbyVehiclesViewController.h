//
//  NearbyVehiclesViewController.h
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NearbyVehiclesViewModel.h"

@interface NearbyVehiclesViewController : UIViewController{
    NearbyVehiclesViewModel *viewModel;
}
    @property (strong, nonatomic) IBOutlet MKMapView *mapView;
    
@end

