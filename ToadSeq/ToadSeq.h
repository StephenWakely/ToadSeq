//
//  TigerSeq.h
//  TigerSeq
//
//  Created by Stephen Wakely on 12/07/2013.
//  Copyright (c) 2013 Stephen Wakely. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^Generator)(BOOL *end);
typedef id(^SimpleTransform)(id value);
typedef id(^Transform)(id value, BOOL *end);

typedef id(^Fold)(id accumulator, id value);
typedef BOOL(^Predicate)(id value);

@interface ToadSeq : NSObject

-(id) initWithGenerator: (Generator) generator;
-(BOOL) hasMore;
-(id) getNext;

-(NSArray *) toArray;

-(ToadSeq *)map: (SimpleTransform) transform;
-(ToadSeq *)foldl: (Fold) transform startingWith: (id) start;
-(ToadSeq *)filter: (Predicate) predicate;
-(ToadSeq *)take: (int)howMany;
-(ToadSeq *)takeWhile: (Predicate) predicate;

@property (copy) Generator generator;

@end
