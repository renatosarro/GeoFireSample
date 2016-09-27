//
//  ViewController.m
//  GeoSample
//
//  Created by Renato Matos on 14/09/16.
//  Copyright © 2016 Renato Matos. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

#define ADDRESS @"Av Sansao Alves dos Santos, 433, Sao Paulo SP, BR"

@interface ViewController ()<GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewMap;
@property (strong, nonatomic) GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet UISlider *sliderZoom;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getGeolocationFromAddress:ADDRESS];
    [self configMap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configMap {
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-23.550520
                                                            longitude:-46.633309
                                                                 zoom:14];
    
    
    self.mapView = [GMSMapView mapWithFrame:self.viewMap.frame camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    
    [self.viewMap addSubview:self.mapView];
}

#pragma mark - Control Actions

- (IBAction)zoomChange:(id)sender {
    
    [self.mapView animateToZoom:self.sliderZoom.value];
    
}

#pragma mark - Map Delegates

- (void)getGeolocationFromAddress:(NSString *)address {
    
    CLGeocoder *geocoder = [CLGeocoder new];
    
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark *aPlacemark in placemarks)
        {
            NSLog(@"[Coordinate Latitude] - %f", aPlacemark.location.coordinate.latitude);
            NSLog(@"[Coordinate Longitude] - %f", aPlacemark.location.coordinate.longitude);
        }
        
    }];
    
}

@end
