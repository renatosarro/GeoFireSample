//
//  ViewController.m
//  GeoSample
//
//  Created by Renato Matos on 14/09/16.
//  Copyright © 2016 Renato Matos. All rights reserved.
//

#import "ViewController.h"

#import "EstabelecimentoAnnotation.h"

#import <GeoFire/GeoFire.h>
#import <Mapbox/Mapbox.h>

@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;

#define ADDRESS @"Av Sansao Alves dos Santos, 433, Sao Paulo SP, BR"
#define SEARCH_RADIUS 0.4

@interface ViewController ()<MGLMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MGLMapView *mapView;

@property (strong, nonatomic) GeoFire *geoFire;
@property (strong, nonatomic) GFCircleQuery *circleQuery;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@property (strong, nonatomic) NSMutableDictionary *listAnnotations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.geoFire = [[GeoFire alloc] initWithFirebaseRef:[[FIRDatabase database] reference]];
    
    [self configGeoSetup];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Config

- (void)configGeoSetup {
    CLLocationCoordinate2D centerCoordinate = [self.mapView convertPoint:self.mapView.center
                                                    toCoordinateFromView:self.view];
    CGSize mySize = self.view.bounds.size;
    CGFloat minSize = fminf(mySize.height, mySize.width)*SEARCH_RADIUS;
    CGPoint pointOnBorder = CGPointMake(mySize.width/2-minSize/2, mySize.height/2);
    
    CLLocationCoordinate2D coordinateOnBorder = [self.mapView convertPoint:pointOnBorder
                                                      toCoordinateFromView:self.view];
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude
                                                            longitude:centerCoordinate.longitude];
    CLLocation *locationOnBorder = [[CLLocation alloc] initWithLatitude:coordinateOnBorder.latitude
                                                              longitude:coordinateOnBorder.longitude];
    CLLocationDistance distance = [centerLocation distanceFromLocation:locationOnBorder]/100000; // in kilometers
    
    self.circleQuery = [self.geoFire queryAtLocation:centerLocation withRadius:distance];
    
    [self setupListeners:self.circleQuery];
}

- (void)setupListeners:(GFQuery *)query
{
    
    [query observeEventType:GFEventTypeKeyEntered withBlock:^(NSString *key, CLLocation *location) {
        
        if (key && location) {
            
            EstabelecimentoAnnotation *annotation = [EstabelecimentoAnnotation new];
            
            annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            annotation.key = key;
            
            self.listAnnotations[key] = annotation;
            [self.mapView addAnnotation:annotation];
            
        } else {
            
            NSLog(@"Não foi encontrado nenhum estabelecimento próximo à sua região");
            
        }
    }];
    
    [query observeEventType:GFEventTypeKeyExited withBlock:^(NSString *key, CLLocation *location) {
        
        if (key && location) {
            
            [self.mapView removeAnnotation:self.listAnnotations[key]];
            [self.listAnnotations removeObjectForKey:key];
        }
    }];
    
    [query observeEventType:GFEventTypeKeyMoved withBlock:^(NSString *key, CLLocation *location) {
        
        if (key && location) {
            
            EstabelecimentoAnnotation *annotation = self.listAnnotations[key];
            annotation.coordinate = location.coordinate;
        }
        
    }];
}

#pragma mark - Control Actions



#pragma mark - Location Delegate

-(CLLocationDistance)locationChange:(CLLocation *)currentLocation
                        newLocation:(CLLocation *)newLocation{
    
    CLLocationDistance km = [newLocation distanceFromLocation:currentLocation] / 1000;
    
    return  km;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        //
        
    }
    
}

#pragma mark - Mapa Delegate
#pragma mark Mapa Custom

- (CGFloat)mapView:(MGLMapView *)mapView lineWidthForPolylineAnnotation:(MGLPolyline *)annotation {
    
    return 7.0;
    
}

- (UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation {
    
    return [UIColor colorWithRed:40.0f/255 green:173.0f/255 blue:205.0f/255 alpha:1];
    
}

#pragma mark Mapa Actions

- (MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id<MGLAnnotation>)annotation {
    
    
    return nil;
}

- (void)mapView:(MGLMapView *)mapView didUpdateUserLocation:(MGLUserLocation *)userLocation {
    
    self.mapView.latitude = userLocation.coordinate.latitude;
    self.mapView.longitude = userLocation.coordinate.longitude;
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    [self configGeoSetup];
    
}

- (void)mapView:(MGLMapView *)mapView didSelectAnnotation:(id<MGLAnnotation>)annotation {
    
    MGLCoordinateBounds bounds = MGLCoordinateBoundsMake(((EstabelecimentoAnnotation *)annotation).coordinate, ((EstabelecimentoAnnotation *)annotation).coordinate);
    [self.mapView setVisibleCoordinateBounds:bounds edgePadding:UIEdgeInsetsMake(100, 100, 100, 100) animated:YES];
    
}



@end
