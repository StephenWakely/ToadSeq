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


-(void) testPrimeGenerator {
    Generator gen = [ToadGenerators Primes];
    
    BOOL end;
    STAssertEquals([gen(&end) intValue], 2, @"First prime is 2");
    STAssertEquals([gen(&end) intValue], 3, @"Second prime is 3");
    STAssertEquals([gen(&end) intValue], 5, @"Third prime is 5");
    STAssertEquals([gen(&end) intValue], 7, @"Fourth prime is 7");
    STAssertEquals([gen(&end) intValue], 11, @"Fifth prime is 11");
    STAssertEquals([gen(&end) intValue], 13, @"Sixth prime is 13");
    STAssertEquals([gen(&end) intValue], 17, @"Seventh prime is 17");
    STAssertEquals([gen(&end) intValue], 19, @"Eighth prime is 19");
    STAssertEquals([gen(&end) intValue], 23, @"Ninth prime is 23");
    STAssertEquals([gen(&end) intValue], 29, @"Tenth prime is 29");
    STAssertEquals([gen(&end) intValue], 31, @"Eleventh prime is 31");
}

@end
