//
//  EstabelecimentoAnnotation.m
//  GeoSample
//
//  Created by Renato Matos on 26/09/16.
//  Copyright © 2016 Renato Matos. All rights reserved.
//

#import "EstabelecimentoAnnotation.h"

@implementation EstabelecimentoAnnotation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.image = [UIImage imageNamed:@"ic_pin"];
    }
    return self;
}

@end
