//
//  TigerSeqTests.m
//  TigerSeqTests
//
//  Created by Stephen Wakely on 12/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

#import "ToadSeqTests.h"
#import "ToadSeq.h"
#import "TestGenerators.h"

@implementation ToadSeqTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}


-(void) testHasMore_GetNext {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];

    STAssertTrue([seq hasMore], @"Should still have more in the sequence");
    STAssertEquals([[seq getNext] intValue], 1, @"First number should be 1");
    STAssertTrue([seq hasMore], @"Should still have more in the sequence");
    STAssertEquals([[seq getNext] intValue], 2, @"First number should be 2");
    STAssertTrue([seq hasMore], @"Should still have more in the sequence");
    STAssertEquals([[seq getNext] intValue], 3, @"First number should be 3");
    
    STAssertFalse([seq hasMore], @"No more than three in the sequence");
}

-(void) testToArray {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];
    NSArray *arr = [seq toArray];

    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@1, @2, @3, nil]];
    STAssertTrue(e, @"Arrays should match");
}

-(void) testMap {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];
    [seq map: ^id(NSNumber *num) {
        return @(num.intValue * 2);
    }];
    NSArray *arr = [seq toArray];
    
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@2, @4, @6, nil]];
    STAssertTrue(e, @"Arrays should match");
}

-(void) testFoldL {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];
    [seq foldl: ^(NSNumber *accumulator, NSNumber *num) {
        return @(accumulator.intValue + num.intValue);
    } startingWith: 0 ];
    
    NSArray *arr = [seq toArray];
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@6, nil]];
    STAssertTrue(e, @"Values should accumulate to 6");
}

-(void) testMapThenFoldL {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];

    // The sum of the squares of the first three integer numbers
    [[seq map: ^id(NSNumber *num) {
        return @(num.intValue * num.intValue);
    }] foldl:^id(NSNumber *accumulator, NSNumber *value) {
        return @(accumulator.intValue + value.intValue);
    } startingWith:0];

    NSArray *arr = [seq toArray];

    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@14, nil]];
    STAssertTrue(e, @"Values should accumulate to 14");
}

-(void) testFilter {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators tenSequentialInts]];

    // Filter the even numbers
    [seq filter: ^BOOL(NSNumber *num)  {
        return num.intValue % 2 == 0;
    }];
    
    NSArray *arr = [seq toArray];
    
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@2, @4, @6, @8, @10, nil]];
    STAssertTrue(e, @"Values should have the even numbers");
}


-(void) testTake {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators infiniteSequentialInts]];
    
    [seq take: 4];
    
    NSArray *arr = [seq toArray];
    
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@1, @2, @3, @4, nil]];
    STAssertTrue(e, @"Values should have the first four numbers");
}

@end
