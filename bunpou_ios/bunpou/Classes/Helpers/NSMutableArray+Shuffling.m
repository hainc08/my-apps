//
//  NSMutableArray+Shuffling.m
//  KanjiBook
//
//  Created by Trần Hải Linh on 2/14/14.
//  Copyright (c) 2014 haimv-pc. All rights reserved.
//

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count =[self count];
    for (int i = 0; i < count; i++) {
        NSUInteger nElement = count - i;
        NSUInteger nRandom = arc4random_uniform(nElement) + i;
        
        [self exchangeObjectAtIndex:i withObjectAtIndex:nRandom];
    }
    
}
@end
