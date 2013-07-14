//
//  TestGenerators.h
//  ToadSeq
//
//  Created by Stephen Wakely on 14/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToadSeq.h"

////
//
// Some useful generators to help the tests.
//
@interface TestGenerators : NSObject

+(Generator) threeSequentialInts;
+(Generator) tenSequentialInts;
+(Generator) infiniteSequentialInts;

@end
