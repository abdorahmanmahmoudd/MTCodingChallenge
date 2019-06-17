//
//  NearbyVehiclesViewController.m
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NearbyVehiclesViewController.h"
#import "MyTaxiCT-Swift.h"

#define METERS_PER_MILE 1609.344
#define DISTANCE_FILTER 10

// MARK: My Location
@interface NearbyVehiclesViewController() {
    
}
-(void) setupMyLocation: (BOOL) shouldUpdateLocation;
-(void) getNearbyVehicles;
-(void) removeAllPinsButUserLocation;
-(void) updateMapRegion;
-(void) setupDragGesture;
@end


@implementation NearbyVehiclesViewController


// MARK: View Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationController].navigationBar.hidden = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    RealAPI *realApi = [[RealAPI alloc] init];
    self.viewModel = [[NearbyVehiclesViewModel alloc] init:realApi];
    [self bindViewModel];
    [self setupMyLocation:NO];
    [self setupDragGesture];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([locationManager locationServicesEnabled]) {
        [locationManager startUpdatingLocation];
    }else{
        [self setupMyLocation: YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([locationManager locationServicesEnabled]) {
        [locationManager stopUpdatingLocation];
        [self.viewModel resetBounds];
    }
}

// MARK: Business logic binding
-(void) bindViewModel {
    
    NearbyVehiclesViewController* __weak weakSelf = self;
    
    self.viewModel.callback = ^(NSMutableArray* locations)  {
        
        [weakSelf removeAllPinsButUserLocation];
        
        for (int i = 0; i < [locations count]; i++) {
            MKPointAnnotation* annotation= [MKPointAnnotation new];
            annotation.coordinate = [(CLLocation*)locations[i] coordinate];
            [weakSelf.mapView addAnnotation: annotation];
        }
    };
}

-(void)removeAllPinsButUserLocation {

    id userLocation = [self.mapView userLocation];
    [self.mapView removeAnnotations: [self.mapView annotations]];

    if ( userLocation != nil ) {
        [self.mapView setShowsUserLocation:true];
    }
}

// MARK: Location services
-(void) setupMyLocation: (BOOL) shouldUpdateLocation {
    
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    
    if ([locationManager locationServicesEnabled]) {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.distanceFilter = DISTANCE_FILTER;
        [self.mapView setShowsUserLocation:true];
        locationManager.showsBackgroundLocationIndicator = true;
        if (shouldUpdateLocation) {
            [locationManager startUpdatingLocation];
        }
    }
}

//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    // get nearby vehicles of default location
//    [self getNearbyVehicles];
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self updateMapRegion];
    [self getNearbyVehicles];
}

-(void) updateMapRegion {
    CLLocationCoordinate2D myLocation = locationManager.location.coordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myLocation, 3.0*METERS_PER_MILE, 3.0*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:NO];
}



-(void) getNearbyVehicles {
    
    MKMapRect visibleRect = self.mapView.visibleMapRect;
    MKMapPoint neMapPoint = MKMapPointMake(MKMapRectGetMaxX(visibleRect), visibleRect.origin.y);
    MKMapPoint swMapPoint = MKMapPointMake(visibleRect.origin.x, MKMapRectGetMaxY(visibleRect));

    CLLocationCoordinate2D neCoord = MKCoordinateForMapPoint(neMapPoint);
    CLLocationCoordinate2D swCoord = MKCoordinateForMapPoint(swMapPoint);

    LocationBounds *bounds = [[LocationBounds alloc] initWithPoint1Long:neCoord.longitude point1Lat:neCoord.latitude point2Long:swCoord.longitude point2Lat:swCoord.latitude];
    [self.viewModel fetchVehicles:bounds];
}


//MARK: Gestures
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



- (void)didDragMap:(UIGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        NSLog(@"drag ended");
        [self getNearbyVehicles];
    }
}

-(void) setupDragGesture {
    UIPanGestureRecognizer* dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMap:)];
    dragGesture.delegate = self;
    [self.mapView addGestureRecognizer:dragGesture];
}

@end

