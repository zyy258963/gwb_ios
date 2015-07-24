/*
	NSSortDescriptor.h
	Foundation
	Copyright (c) 2002-2014, Apple Inc. All rights reserved.
*/

#import <Foundation/NSArray.h>
#import <Foundation/NSSet.h>
#import <Foundation/NSOrderedSet.h>


@interface NSSortDescriptor : NSObject <NSSecureCoding, NSCopying> {
@private
    NSUInteger _sortDescriptorFlags;
    NSString *_key;
    SEL _selector;
    id _selectorOrBlock;
}

+ (instancetype)sortDescriptorWithKey:(NSString *)key ascending:(BOOL)ascending NS_AVAILABLE(10_6, 4_0);
+ (instancetype)sortDescriptorWithKey:(NSString *)key ascending:(BOOL)ascending selector:(SEL)selector NS_AVAILABLE(10_6, 4_0);

// keys may be key paths
- (instancetype)initWithKey:(NSString *)key ascending:(BOOL)ascending;
- (instancetype)initWithKey:(NSString *)key ascending:(BOOL)ascending selector:(SEL)selector;

@property (readonly, copy) NSString *key;
@property (readonly) BOOL ascending;
@property (readonly) SEL selector;

- (void)allowEvaluation NS_AVAILABLE(10_9, 7_0); // Force a sort descriptor which was securely decoded to allow evaluation

+ (instancetype)sortDescriptorWithKey:(NSString *)key ascending:(BOOL)ascending comparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);

- (instancetype)initWithKey:(NSString *)key ascending:(BOOL)ascending comparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);

@property (readonly) NSComparator comparator NS_AVAILABLE(10_6, 4_0);

- (NSComparisonResult)compareObject:(id)object1 toObject:(id)object2;    // primitive - override this method if you want to perform comparisons differently (not key based for example)
@property (readonly, retain) id reversedSortDescriptor;    // primitive - override this method to return a sort descriptor instance with reversed sort order

@end

@interface NSSet (NSSortDescriptorSorting)

- (NSArray *)sortedArrayUsingDescriptors:(NSArray *)sortDescriptors NS_AVAILABLE(10_6, 4_0);    // returns a new array by sorting the objects of the receiver

@end

@interface NSArray (NSSortDescriptorSorting)

- (NSArray *)sortedArrayUsingDescriptors:(NSArray *)sortDescriptors;    // returns a new array by sorting the objects of the receiver

@end

@interface NSMutableArray (NSSortDescriptorSorting)

- (void)sortUsingDescriptors:(NSArray *)sortDescriptors;    // sorts the array itself

@end

@interface NSOrderedSet (NSKeyValueSorting)

// returns a new array by sorting the objects of the receiver
- (NSArray *)sortedArrayUsingDescriptors:(NSArray *)sortDescriptors NS_AVAILABLE(10_7, 5_0);

@end

@interface NSMutableOrderedSet (NSKeyValueSorting)

// sorts the ordered set itself
- (void)sortUsingDescriptors:(NSArray *)sortDescriptors NS_AVAILABLE(10_7, 5_0);

@end
