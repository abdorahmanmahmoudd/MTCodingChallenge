//
//  NearbyVehiclesViewModel.h
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <MyTaxiCT-Swift.h>


@interface NearbyVehiclesViewModel : NSObject {
    
    APIProvider *apiProvider;
    LocationBounds *bounds;
}

@property (nonatomic, strong) VehiclesObjc *nearbyVehicles;
@property (nonatomic, strong) NSMutableArray *nearbyVehiclesLocations;
@property (nonatomic, strong) void (^callback) (NSMutableArray*);

-(instancetype)init: (id<InteroperableMyTaxiAPI>) myAPI;

-(void) fetchVehicles: (LocationBounds*)bounds ;
-(void) resetBounds;

@end
