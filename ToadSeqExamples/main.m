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


void SumOfFactors ()
{
    // Start with all numbers between 1 and 999
    int result = [[[[[ToadSeq withGenerator: [ToadGenerators rangeFrom:1 to:49999]]
                  
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
    printf("Sum of factors of 5 and 7 between 1 and 50000 : %d\n", result);
}

void NthPrimeNumber ()
{
    int result = [[[[ToadSeq withGenerator: [ToadGenerators Primes]]
                    skip: 518238] getNext] intValue];
    
    printf("518239th prime number: %d\n", result);
}


int main(int argc, const char * argv[])
{
    SumOfFactors();
    NthPrimeNumber();
    
    return 0;
}

