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


#import <Foundation/Foundation.h>
#import "ToadSeq.h"

////
//
//  Generators are blocks that provide the original source of data for the
//   transformations.
//
//  Each block is of the form ^id(BOOL *end).
//  Each time they are called they will return the next value in the sequence
//    and will set *end to be NO. When they have run out of data they will set
//    *end to be YES. They should also return nil - although this should not be
//    relied on.
//
//  Note that not all generators will end. For example to infiniteSequentialInts will
//    carry on (its behaviour will be undefined at MaxInt.) It is up to you to make
//    sure you only take as many values as you need.
//
//
@interface ToadGenerators : NSObject

////
//
// Returns an infinite sequence of ints. Will be undefined when it gets to MaxInt.
// Note the sequence is of objects of type NSNumber. If you need to do arithmetic
// with the values then use the intValue property of the values.
//
+(Generator) infiniteSequentialInts;


////
//
// Returns a seqence of integers between from and to.
//
//
+(Generator) rangeFrom:(int) from to:(int) to;

////
//
// Returns a sequence of the elements of the array.
//
+(Generator) NSArraySeq: (NSArray *) arr;

////
//
// Returns a sequence of the keys of the dictionary.
//
+(Generator) NSDictionarySeq: (NSDictionary *)dict;


////
//
// Returns an infinite (subject to memory and time) sequence of prime numbers
//
+(Generator) Primes;

@end
