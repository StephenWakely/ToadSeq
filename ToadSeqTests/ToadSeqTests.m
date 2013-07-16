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
#import "ToadGenerators.h"

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

-(void) testForEach {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];
    NSMutableArray *test = [[NSMutableArray alloc] initWithCapacity: 3];
    [seq forEach:^(id value) {
        [test addObject: value];
    }];

    BOOL e = [test isEqualToArray: [NSArray arrayWithObjects:@1, @2, @3, nil]];
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
    } ];
    
    NSArray *arr = [seq toArray];
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@6, nil]];
    STAssertTrue(e, @"Values should accumulate to 6");
}

-(void) testFoldLWithStart {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];
    [seq foldl: ^(NSNumber *accumulator, NSNumber *num) {
        return @(accumulator.intValue + num.intValue);
    } startingWith: @50 ];
    
    NSArray *arr = [seq toArray];
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@56, nil]];
    STAssertTrue(e, @"Values should accumulate to 56");
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


-(void) testTakeWhile {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators infiniteSequentialInts]];

    // Take until we get to > 5.
    [seq takeWhile: ^BOOL(NSNumber *num) {
        return num.intValue <= 5;
    }];
    
    NSArray *arr = [seq toArray];
    
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@1, @2, @3, @4, @5, nil]];
    STAssertTrue(e, @"Values should have the first five numbers");
}

-(void) testConcat {
    ToadSeq *seq1 = [[ToadSeq alloc] initWithGenerator: [TestGenerators infiniteSequentialInts]];
    ToadSeq *seq2 = [[ToadSeq alloc] initWithGenerator: [TestGenerators infiniteSequentialInts]];
    
    [[seq1 take: 5] concatWith: [seq2 take: 3]];
    
    NSArray *arr = [seq1 toArray];
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@1, @2, @3, @4, @5, @1, @2, @3, nil]];
    STAssertTrue(e, @"Values were %@", [arr componentsJoinedByString:@","]);
}

-(void) testSumFirstTenSquares {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [ToadGenerators infiniteSequentialInts]];
    [[[seq take: 10]
           map:^id(NSNumber *value) {
             return @(value.intValue * value.intValue);
        }]
          foldl:^id(NSNumber *accumulator, NSNumber *value) {
              return @(accumulator.intValue + value.intValue);
        }];

    STAssertTrue([seq hasMore], @"Should have one item");
    STAssertEquals([[seq getNext] intValue], 385, @"We need the sum of the squares here");
}

-(void) testReverse {
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [TestGenerators threeSequentialInts]];
    [seq reverse];
    
    NSArray *arr = [seq toArray];
    BOOL e = [arr isEqualToArray: [NSArray arrayWithObjects:@3, @2, @1, nil]];
    STAssertTrue(e, @"Values were %@", [arr componentsJoinedByString:@","]);    
}

-(void) testStringArrays {
    NSString *sentence = @"I love to boogy";
    NSArray *arr = [sentence componentsSeparatedByString: @" "];
    
    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [ToadGenerators NSArraySeq: arr]];
    [seq map:^NSString *(NSString *word) {
        return [word capitalizedString];
    }];
    
    STAssertTrue([[[seq toArray] componentsJoinedByString:@" "] isEqualToString: @"I Love To Boogy"], @"String should be capitalized" );
}


@end
