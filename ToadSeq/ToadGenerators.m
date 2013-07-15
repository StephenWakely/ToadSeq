//
//  ToadGenerators.m
//  ToadSeq
//
//  Created by Stephen Wakely on 15/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

#import "ToadGenerators.h"

@implementation ToadGenerators


+(Generator) infiniteSequentialInts {
    __block int i = 1;
    
    return ^id(BOOL *end) {
        return @(i++);
    };
}


+(Generator) NSArraySeq: (NSArray *) arr {
    __block int idx = 0;
    
    return ^id(BOOL *end) {
        if (idx >= arr.count) {
            *end = YES;
            return nil;
        }
        
        return arr[idx++];
    };
}

+(Generator) NSDictionarySeq: (NSDictionary *)dict {
    NSEnumerator *enrator = dict.keyEnumerator;
    
    return ^id(BOOL *end) {
        id key = [enrator nextObject];
        if (!key)
            *end = YES;
        return key;
    };
}


@end
