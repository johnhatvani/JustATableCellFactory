//
//  JAObjectMapping.m
//  JATableCellFactory
//
//  Created by John Hatvani on 24/03/13.
//  Copyright (c) 2013 electric-mind. All rights reserved.
//

#import "JAObjectMapping.h"

@interface JAObjectMapping ()

- (id) initWithModelClass:(Class)oc toCell:(Class)cellClass optionalNibName:(NSString *)nibNameOrNil;

@end

@implementation JAObjectMapping

#pragma mark - initializer;

+ (JAObjectMapping *) mappingFromModelClass:(Class)objectClass toCellClass:(Class)cellClass nibName:(NSString *)nibName
{
    if([cellClass isSubclassOfClass:UITableViewCell.class])
    {
        return [[JAObjectMapping alloc] initWithModelClass:objectClass toCell:cellClass optionalNibName:nibName];
    }
    NSAssert(NO, @"Cell class NEEDS to be a UITableViewCell Subclass");
    return nil;
}

+ (JAObjectMapping *) mappingFromModelClass:(Class)objectClass toCellClass:(Class)cellClass
{
    return [JAObjectMapping mappingFromModelClass:objectClass toCellClass:cellClass nibName:nil];
}

- (id) initWithModelClass:(Class)oc toCell:(Class)cellClass optionalNibName:(NSString *)nibNameOrNil
{
    self = [super init];
    
    if(self)
    {
        self.cellClass   = cellClass;
        self.objectClass = oc;
    }
    
    return self;
}

- (id) init
{
    NSAssert(NO, @"Use Static Initializer");
    return nil;
}

#pragma mark - equality check

- (NSUInteger) hash
{
    NSUInteger hash = 0;
    
    hash ^= [self.objectClass hash];
    hash ^= [self.cellClass hash];
    
    return hash;
}

- (BOOL) isEqual:(id)object
{
    if([object isKindOfClass:self.class])
    {
        return self.hash == ((JAObjectMapping *)object).hash;
    }
    return NO;
}

@end
