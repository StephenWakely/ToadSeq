//
//  main.m
//  ToadSeqExamples
//
//  Created by Stephen Wakely on 03/08/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

#include <stdio.h>
#import <Foundation/Foundation.h>
#import "ToadSeq.h"
#import "ToadGenerators.h"


void Euler1 ()
{
    // Start with all numbers between 1 and 999
    int result = [[[[[ToadSeq withGenerator: [ToadGenerators rangeFrom:1 to:999]]
                  
                    // Take only multiples of 3 or 5
                    filter:^BOOL(NSNumber *value) {
                        return value.intValue % 3 == 0 || value.intValue % 5 == 0;
                    }]

                    // Add the values together.
                    foldl:^id(NSNumber *accumulator, NSNumber *value) {
                        return @(accumulator.intValue + value.intValue);
                    }]
    
                    // Get the result and convert to integer.
                    getNext] intValue];
    
    
    // insert code here...
    printf("Euler 1: %d\n", result);
}

void Euler7 ()
{
    int result = [[[[ToadSeq withGenerator: [ToadGenerators Primes]]
                    skip: 10000] getNext] intValue];
    
    printf("Euler 7: %d\n", result);
}


int main(int argc, const char * argv[])
{
    Euler1();
    Euler7();
    
    return 0;
}

