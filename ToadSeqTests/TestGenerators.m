//
//  TestGenerators.m
//  ToadSeq
//
//  Created by Stephen Wakely on 14/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//


#import "TestGenerators.h"

@implementation TestGenerators

+(Generator) threeSequentialInts {
    __block int i = 1;
    
    return ^id(BOOL *end) {
        if (i == 4) {
            *end = YES;
            return nil;
        }
        
        return @(i++);
    };
}

+(Generator) tenSequentialInts {
    __block int i = 1;
    
    return ^id(BOOL *end) {
        if (i == 11) {
            *end = YES;
            return nil;
        }
        
        return @(i++);
    };
}

+(Generator) infiniteSequentialInts {
    __block int i = 1;
    
    return ^id(BOOL *end) {
        return @(i++);
    };
}


@end
