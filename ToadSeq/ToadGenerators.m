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
