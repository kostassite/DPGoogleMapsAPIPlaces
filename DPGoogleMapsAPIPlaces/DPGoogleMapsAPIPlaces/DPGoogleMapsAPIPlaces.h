//
//  DPGoogleMapsAPIPlaces.h
//  DPGoogleMapsAPIPlaces
//
//  Created by Kostas Antonopoulos on 27/2/13.
//  Copyright (c) 2013 Kostas Antonopoulos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPGoogleMapsAPIPlaces;

@protocol DPGoogleMapsAPIPlacesDelegate <NSObject>

-(void)placesAPIFailed:(DPGoogleMapsAPIPlaces*)googleMapsAPIPlaces;

@required
-(void)placesAPI:(DPGoogleMapsAPIPlaces*)googleMapsAPIPlaces completedSuccessfullyWithArray:(NSArray*)places;


@end

@interface DPGoogleMapsAPIPlaces : NSObject

-(DPGoogleMapsAPIPlaces*)initWithApiKey:(NSString*)api;

@property (nonatomic,weak) id<DPGoogleMapsAPIPlacesDelegate> delegate;


-(void)searchFor:(NSString*)searchStr;

-(NSInteger)numberOfPlaces;
-(NSString*)placeAtIndex:(NSInteger)index;

@end
