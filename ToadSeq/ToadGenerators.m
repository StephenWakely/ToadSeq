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

+(Generator) rangeFrom:(int) from to:(int) to {
    __block int i = from;
    
    return ^id(BOOL *end) {
        if (i > to) {
            *end = YES;
            return nil;
        }
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


+(Generator) Primes {
    NSMutableDictionary *nonprimes = [[NSMutableDictionary alloc] init];
    __block int next = 1;
 
    return ^id(BOOL *end) {
        while (true) {
            next++;

            NSNumber *p = nonprimes[@(next)];
            
            if (!p) {
                // next is not a key, so must be prime - add it's square to the dictionary
                nonprimes[@(next * next)] = @(next);
                *end = NO;
                return @(next);
            }
            
            // Find the next composite number.
            NSNumber *c = @(next + p.intValue);
            while  (nonprimes[c])
                c = @(c.intValue + p.intValue);
            
            nonprimes[c] = p;
            
        }
    };
}

@end
