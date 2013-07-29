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
typedef void(^Action) (id value);
typedef id(^Fold)(id accumulator, id value);
typedef BOOL(^Predicate)(id value);

@interface ToadSeq : NSObject


+(ToadSeq *)withGenerator: (Generator) generator;

/*
 Initialise the sequence with a Generator.

 A generator is a block of type ^id(BOOL *end).
*/
-(id) initWithGenerator: (Generator) generator;

/*
 Return YES if there are more elements available in the sequence.
*/
-(BOOL) hasMore;

/*
 Returns the next element of the sequence.
*/
-(id) getNext;

/*
 Returns an array containing the results of the sequence.
 Do not call for infinite sequences - it will never return (but will run out of memory).
 */
-(NSArray *) toArray;

/*
 Loops over the sequence and calls the action block, presumably for sideeffects.
 */
-(void) forEach: (Action) action;

/*
 Transform all the elements of the sequence to the values transformed by the action.
*/
-(ToadSeq *)map: (SimpleTransform) transform;

/*
 Folds from the left of the sequence.
 The accumulator starts as the startWith parameter passed in.
*/
-(ToadSeq *)foldl: (Fold) transform startingWith: (id) start;

/*
 Folds from the left of the sequence.
 The accumulator starts with the first item in the sequence
*/
-(ToadSeq *)foldl: (Fold) transform;

/*
 Remove all the items from the sequence where the predicate returns false.
*/
-(ToadSeq *)filter: (Predicate) predicate;

/*
 Return only the first n elements from the sequence.
*/
-(ToadSeq *)take: (int)howMany;

/*
 Continue returning elements from the sequence until the predicate returns false.
 */
-(ToadSeq *)takeWhile: (Predicate) predicate;

/*
 Concatenate this sequence with the given one.
*/
-(ToadSeq *)concatWith: (ToadSeq *)seq;

/*
    Reverses the sequence. Be careful with this one as the whole sequence has
    to be loaded into memory in order to reverse it. 
 
    Will NOT work with infinite sequences.
*/
-(ToadSeq *)reverse;


@property (copy) Generator generator;

@end
