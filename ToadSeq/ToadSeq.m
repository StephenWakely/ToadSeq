//
//  TigerSeq.m
//  TigerSeq
//
//  Created by Stephen Wakely on 12/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

#import "ToadSeq.h"

@interface ToadSeq()

@property (copy) Generator generator;
@property (weak) id cachedNext;
@property (assign) BOOL nextValueCached;

@property (strong) NSMutableArray *transforms;

@end


@implementation ToadSeq

-(id)initWithGenerator: (Generator) generator {
    if ( self = [super init]) {
        self.generator = generator;
        self.transforms = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(BOOL) hasMore {
    BOOL end = NO;

    self.cachedNext = self.generator(&end);
    self.nextValueCached = !end;

    return !end;
}

-(id) getNext {
    BOOL end = NO;

    if (self.nextValueCached) {
        self.nextValueCached = NO;
        return self.cachedNext;
    }

    id next = self.generator(&end);
    return end ? nil : next;
}


-(NSArray *) toArray {
    BOOL end = NO;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    id next = self.generator(&end);
    while (!end) {
        [arr addObject: next];
        next = self.generator(&end);
    }
    
    return arr;
}


-(ToadSeq *)map: (SimpleTransform) transform {
    // Capture the last generator in the sequence.
    Generator gen = self.generator;

    self.generator = ^id (BOOL *end) {
        id value = gen(end);
        return *end? nil : transform(value);
    };

    // Return self so we can chain
    return self;
}

-(ToadSeq *)foldl: (Fold) transform startingWith: (id) start {
    // Capture the last generator in the sequence
    Generator gen = self.generator;
    __block BOOL accumulated = NO;
    
    self.generator = ^id (BOOL *end) {
        if (accumulated || *end) {
            // We've already done the accumulation.
            *end = YES;
            return nil;
        }
        
        id accum = start;
        BOOL e = NO;
        while (!e) {
            id value = gen(&e);
            if (!e)
                accum = transform(accum, value);
        }
        
        accumulated = YES;
        return accum;
    };
    
    return self;
}


-(ToadSeq *)filter: (Filter) predicate {
    // Capture the last generator in the sequence
    Generator gen = self.generator;

    self.generator = ^id (BOOL *end) {
        id value = gen(end);
        // Loop until we get to the end or satisfy the predicate.
        while (!*end && !predicate(value)) {
            value = gen(end);
        }
        
        return *end ? nil : value;
    };
    
    return self;
}


@end
