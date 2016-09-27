//
//  EstabelecimentoAnnotation.h
//  GeoSample
//
//  Created by Renato Matos on 26/09/16.
//  Copyright © 2016 Renato Matos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>

@interface EstabelecimentoAnnotation : NSObject<MGLAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *key;

@end
