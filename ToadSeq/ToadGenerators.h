//
//  ToadGenerators.h
//  ToadSeq
//
//  Created by Stephen Wakely on 15/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

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
