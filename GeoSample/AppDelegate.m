//
//  AppDelegate.m
//  GeoSample
//
//  Created by Renato Matos on 14/09/16.
//  Copyright © 2016 Renato Matos. All rights reserved.
//

#import "AppDelegate.h"

@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GMSServices provideAPIKey:@"AIzaSyD1uYbGLQK73JvXosXYDkjQYMSvBwSESJc"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyD1uYbGLQK73JvXosXYDkjQYMSvBwSESJc"];
    
    return YES;
}

@end
