//
//  NearbyVehiclesViewModel.m
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyVehiclesViewModel.h"
#import <MapKit/MapKit.h>
#import "MyTaxiCT-Swift.h"


@implementation NearbyVehiclesViewModel

- (instancetype)init: (id<InteroperableMyTaxiAPI>) myAPI {
    if (self = [super init]) {
        apiProvider = (id)myAPI;
        _nearbyVehiclesLocations = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) fetchVehicles:(LocationBounds *)bounds {
    
    if ([self->bounds isEqual:bounds]){
        NSLog(@"Duplicate bounds");
        return;
    }
    
    self->bounds = bounds;
    [apiProvider fetchVehiclesWithinBounds:bounds success:^(id<NSCoding> response) {
        
        if ( ((VehiclesObjc *)response) != nil && [((VehiclesObjc *)response).poiList count] > 0 ) {
            
            self.nearbyVehicles = (VehiclesObjc *)response;
            [self.nearbyVehiclesLocations removeAllObjects];
            for (VehicleObjc* vehicle in self.nearbyVehicles.poiList) {
                [self.nearbyVehiclesLocations addObject: [self getVehicleLocation:vehicle] ];
            }
            if (self.callback != nil) {
                NSLog(@"vehicles counter %lu", (unsigned long)[self.nearbyVehiclesLocations count]);
                self.callback(self.nearbyVehiclesLocations);
            }
            
        }else {
            [self.nearbyVehiclesLocations removeAllObjects];
            self.nearbyVehicles = [[VehiclesObjc alloc] init];
            NSLog(@"No nearby vehicles.");
        }

        
    } failure:^(NSError * error) {
        NSLog(@"failure: %@", error.localizedDescription);
    }];
}

-(CLLocation*) getVehicleLocation: (VehicleObjc*) vehicle {
    CLLocationDegrees lat = [vehicle.coordinate.latitude doubleValue];
    CLLocationDegrees lon = [vehicle.coordinate.longitude doubleValue];
    CLLocation *vehicleLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    return vehicleLocation;
}

-(void) resetBounds {
    bounds = NULL;
}
    
@end
