//
//  GeneratorTests.m
//  ToadSeq
//
//  Created by Stephen Wakely on 15/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

#import "GeneratorTests.h"
#import "ToadGenerators.h"

@implementation GeneratorTests


-(void) testArrayGenerator {
    NSArray *arr = [NSArray arrayWithObjects:@"funky", @"groovy", @"rocking", nil];
    Generator gen = [ToadGenerators NSArraySeq:arr];
    
    BOOL end;
    id next = gen(&end);
    STAssertEquals(end, NO, @"Should still be some left");
    STAssertTrue([next isEqualToString: @"funky"], @"First should be funky");

    next = gen(&end);
    STAssertEquals(end, NO, @"Should still be some left");
    STAssertTrue([next isEqualToString: @"groovy"], @"Second should be groovy");

    next = gen(&end);
    STAssertEquals(end, NO, @"Should still be some left");
    STAssertTrue([next isEqualToString: @"rocking"], @"Third should be rocking");

    next = gen(&end);
    STAssertEquals(end, YES, @"Shouldn't have anymore");
    STAssertNil(next, @"No more values to go");    
}

@end
