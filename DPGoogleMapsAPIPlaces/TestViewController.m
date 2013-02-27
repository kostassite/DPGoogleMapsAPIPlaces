//
//  TestViewController.m
//  DPGoogleMapsAPIPlaces
//
//  Created by Kostas Antonopoulos on 27/2/13.
//  Copyright (c) 2013 Kostas Antonopoulos. All rights reserved.
//

#import "TestViewController.h"
#import "DPGoogleMapsAPIPlaces.h"

#define APIKEY @"" //Add your APIKEY

@interface TestViewController ()<DPGoogleMapsAPIPlacesDelegate>{
	DPGoogleMapsAPIPlaces *googleMapsPlaces;
	__weak IBOutlet UITextField *searchTextField;
}

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	googleMapsPlaces = [[DPGoogleMapsAPIPlaces alloc]initWithApiKey:APIKEY];
	[googleMapsPlaces setDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchPressed:(id)sender {
	[googleMapsPlaces searchFor:searchTextField.text];

}

#pragma mark - DPGoogleMapsAPIPlacesDelegate

-(void)placesAPI:(DPGoogleMapsAPIPlaces *)googleMapsAPIPlaces completedSuccessfullyWithArray:(NSArray *)places{
	
	NSLog(@"%@",places);
}
@end
