ToadSeq
=======

A iOS library for generating and manipulating lazy sequences.

**Generators**

A sequence starts with a *Generator* - a Block of type `^id(BOOL *end)`. On each invocation the block returns the next item in the sequence. At the end of the sequence (if there is an end) the sequence sets end to YES.

A generator that returns the first five integers can be created like :

    +(Generator) firstFiveInts {
        __block int i = 1;
    
        return ^id(BOOL *end) {
            if (i > 5) {
              end = YES;
              return nil;
            }

            return @(i++);
        };
    }

A number of generators have been pre-defined in ToadGenerators.h :

   [ToadGenerators infiniteSequentialInts]

Creates an infinite sequence of integers.

   [ToadGenerators NSArraySeq: array]
 
Creates a sequence containing the elements of the passed in array.

   [ToadGenerators NSDictionarySeq: dict]

Creates a sequence containing the keys of the passed in dictionary.


**Transformations**

The sequence can then be manipulated using a number of chained transformations.

To create a sequence of even numbers use `map` :

    ToadSeq *seq = [[ToadSeq alloc] initWithGenerator: [ToadGenerators infiniteSequentialInts]];
    [seq map: ^id(NSNumber *num) {
        return @(num.intValue * 2);
    }];

Transformations can be chained. To get the sum of the first 10 square numbers using take, map and foldl:

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


**Pulling the data**

Nothing happens until we actually pull the data. Applying the transformations just chain them up. Only when we pull a value from the sequence with getNext is it passed through the transformations and returned. Only as much data as is needed is passed through the transformations. There is no need (apart from in a few situations) to store intermediate arrays of data which uses up unnecessary memory.

Data can be pulled using :

`[seq getNext]` - Used in conjunction with `[seq hasMore]` to pull a single item from the sequence.

`[seq toArray]` - Pulls the whole sequence out into an array.

`[seq forEach:]` - Passes each element of the sequence into a block.





