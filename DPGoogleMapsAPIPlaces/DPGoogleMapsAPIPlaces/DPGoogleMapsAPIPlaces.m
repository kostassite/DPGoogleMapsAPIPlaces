//
//  DPGoogleMapsAPIPlaces.m
//  DPGoogleMapsAPIPlaces
//
//  Created by Kostas Antonopoulos on 27/2/13.
//  Copyright (c) 2013 Kostas Antonopoulos. All rights reserved.
//

#import "DPGoogleMapsAPIPlaces.h"
#import "JSONKit.h"

@interface DPGoogleMapsAPIPlaces () <NSURLConnectionDelegate,NSURLConnectionDataDelegate> {
	NSString *placesAPIkey;
	NSMutableArray *places;
	
	NSMutableData *receivedData;
}

@end

@implementation DPGoogleMapsAPIPlaces

-(DPGoogleMapsAPIPlaces*)initWithApiKey:(NSString*)api{
	if (self=[super init]) {
		placesAPIkey = [api copy];
	}
	return self;
}


-(void)searchFor:(NSString*)searchStr{
	receivedData = [[NSMutableData alloc]init];
	
	NSString *urlStr = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=false&key=%@",searchStr,placesAPIkey];
	
	NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] delegate:self];
	
	[conn start];
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	if (self.delegate && [self.delegate respondsToSelector:@selector(placesAPIFailed:)]) {
		[self.delegate placesAPIFailed:self];
	}
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	NSArray *results = [[receivedData objectFromJSONData] objectForKey:@"predictions"];
	places = [[NSMutableArray alloc]init];
	
	for (NSDictionary *dict in results) {
		[places addObject:[dict objectForKey:@"description"]];
	}
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(placesAPI:completedSuccessfullyWithArray:)]) {
		[self.delegate placesAPI:self completedSuccessfullyWithArray:[places copy]];
	}
	
}


#pragma mark - Datasource

-(NSInteger)numberOfPlaces{
	return [places count];
}

-(NSString*)placeAtIndex:(NSInteger)index{
	return [places objectAtIndex:index];
}

@end
