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

typedef id(^Generator)(BOOL *end);
typedef id(^SimpleTransform)(id value);
typedef id(^Transform)(id value, BOOL *end);
typedef void(^Action) (id value);
typedef id(^Fold)(id accumulator, id value);
typedef BOOL(^Predicate)(id value);

@interface ToadSeq : NSObject


+(ToadSeq *)withGenerator: (Generator) generator;

/**
 * Initialise the sequence with a Generator.
 *
 * A generator is a block of type ^id(BOOL *end).
 *
 *	@param	generator	A ToadGenerator - the block which pumps out the initial sequence
 *
 *	@return	ToadSeq
 */
-(id) initWithGenerator: (Generator) generator;


/**
 *	 Return YES if there are more elements available in the sequence.
 *
 *	@return	Are the more elements available
 */
-(BOOL) hasMore;


/**
 *	 Returns the next element of the sequence.
 *
 *	@return	The next element
 */
-(id) getNext;


/**
 * Returns an array containing the results of the sequence.
 * Do not call for infinite sequences - it will never return (but will run out of memory).
 *
 *	@return	An array of the sequence
 */
-(NSArray *) toArray;


/**
 *	 Loops over the sequence and calls the action block, presumably for sideeffects.
 *
 *	@param	action	Block to act on each element
 */
-(void) forEach: (Action) action;


/**
 * Transform all the elements of the sequence to the values transformed by the action.
 *
 *	@param	transform A block that takes one element and returns the transformed element
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)map: (SimpleTransform) transform;


/**
 *	 Folds from the left of the sequence.
 * The accumulator starts as the startWith parameter passed in.
 *
 *	@param	transform	A block that takes the accumulated value and the next element of the sequence. 
 *                      The accumulated value should be returned from the block.
 *	@param	start The value to initialise the accumulated value as.
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)foldl: (Fold) transform startingWith: (id) start;


/**
 * Folds from the left of the sequence.
 * The accumulator starts with the first item in the sequence
 *
 *	@param	transform	A block that takes the accumulated value and the next element of the sequence.
 *                      The accumulated value should be returned from the block.
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)foldl: (Fold) transform;

/**
 *	 Remove all the items from the sequence where the predicate returns false.
 *
 *	@param	predicate	A block that takes an element of the sequence and returns True if the value should be in the resulting sequence
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)filter: (Predicate) predicate;

/*
 */
/**
 *  Ignore the first n elements from the sequence
 *
 *	@param	howMany	How many items to ignore.
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)skip: (int)howMany;

/**
 *	 Return only the first n elements from the sequence.
 *
 *	@param	howMany	How many items to take from the sequence
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)take: (int)howMany;


/**
 *	 Continue returning elements from the sequence until the predicate returns false.
 *
 *	@param	predicate	A predicate with takes an element of the sequence and returns true if we should continue taking items.
 *                      When we return False, the sequence ends.
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)takeWhile: (Predicate) predicate;


/**
 *	 Concatenate this sequence with the given one.
 *      The sequence is still accessed lazily.
 *
 *	@param	seq	The sequence to concatenate with.
 *
 *	@return	The ToadSeq object so further transformations can be added
 */
-(ToadSeq *)concatWith: (ToadSeq *)seq;

/**
 *	    Reverses the sequence. Be careful with this one as the whole sequence has
 * to be loaded into memory in order to reverse it.
 *
 * Will NOT work with infinite sequences.
 *
 *	@return	<#return value description#>
 */
-(ToadSeq *)reverse;


@property (copy) Generator generator;

@end
