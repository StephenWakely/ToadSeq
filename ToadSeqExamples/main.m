/*
 
 The MIT License (MIT)
 
 Copyright (c) 2013 Stephen Wakely
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */


#include <stdio.h>
#import <Foundation/Foundation.h>
#import "ToadSeq.h"
#import "ToadGenerators.h"

/**
 *	Gets the sum of all factors of 5 and 7 between 1 and 50000
 *
 */
void SumOfFactors ()
{
    // Start with all numbers between 1 and 999
    int result = [[[[[ToadSeq withGenerator: [ToadGenerators rangeFrom:1 to:49999]]
                  
                    // Take only multiples of 5 or 7
                    filter:^BOOL(NSNumber *value) {
                        return value.intValue % 5 == 0 || value.intValue % 7 == 0;
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

/**
 *	Returns the 518239th prime number
 *
 */
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

