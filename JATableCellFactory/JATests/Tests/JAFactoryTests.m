//
//  JAFactoryTests.m
//  JATableCellFactory
//
//  Created by John Hatvani on 24/03/13.
//  Copyright (c) 2013 electric-mind. All rights reserved.
//

#import <GHUnitIOS/GHTestCase.h>

#import "JACellFactory.h"
#import "JAObjectMapping.h"

#import "TestObjectA.h"
#import "TestObjectB.h"
#import "TestObjectSubA.h"

@interface JACellFactory (sneaky)

@property (nonatomic, strong) NSMutableArray *store;
- (JAObjectMapping *) mappingFromObject:(id)object;

@end

@interface JAFactoryTests : GHTestCase

@end


@implementation JAFactoryTests
{
    JACellFactory *factory;
}

- (void) setUpClass
{
    factory = [JACellFactory getInstance];
}

- (void) tearDown
{
    [factory.store removeAllObjects];
}

- (void) testMappingFromObject
{
    JAObjectMapping *mapping1 = [JAObjectMapping mappingFromModelClass:[TestObjectA class] toCellClass:[UITableViewCell class]];
    JAObjectMapping *mapping2 = [JAObjectMapping mappingFromModelClass:[TestObjectB class] toCellClass:[UITableViewCell class]];
    
    [factory addObjectMapping:mapping1];
    [factory addObjectMapping:mapping2];
    
    TestObjectB *b = [[TestObjectB alloc] init];
    
    JAObjectMapping *result = [factory mappingFromObject:b];
    
    GHTestLog(@"'%@'", result);
    GHTestLog(@"'%@'", mapping2);
    
    GHAssertTrue([result isEqual:mapping2], @"[FAILURE] Expected(%@) got(%@)(Objects Should be the same)", result, mapping2);
}

- (void) testMappingFromObjectSubclass
{
    JAObjectMapping *mapping1 = [JAObjectMapping mappingFromModelClass:[TestObjectA class] toCellClass:[UITableViewCell class]];
    JAObjectMapping *mapping2 = [JAObjectMapping mappingFromModelClass:[TestObjectB class] toCellClass:[UITableViewCell class]];
    
    [factory addObjectMapping:mapping1];
    [factory addObjectMapping:mapping2];
    
    TestObjectSubA *sa = [[TestObjectSubA alloc] init];
    
    JAObjectMapping *result = [factory mappingFromObject:sa];
    
    GHTestLog(@"'%@'", result);
    GHAssertTrue(result == nil, @"[FAILURE] Expected(%@) got(%@) (Result should be nil)", nil, result);
}

- (void) testMappingFromObjectSubclassRetrieval
{
    JAObjectMapping *mapping1 = [JAObjectMapping mappingFromModelClass:[TestObjectA class]    toCellClass:[UITableViewCell class]];
    JAObjectMapping *mapping2 = [JAObjectMapping mappingFromModelClass:[TestObjectB class]    toCellClass:[UITableViewCell class]];
    JAObjectMapping *mapping3 = [JAObjectMapping mappingFromModelClass:[TestObjectSubA class] toCellClass:[UITableViewCell class]];
    
    [factory addObjectMapping:mapping1];
    [factory addObjectMapping:mapping2];
    [factory addObjectMapping:mapping3];
    
    TestObjectSubA *sa = [[TestObjectSubA alloc] init];
    
    JAObjectMapping *result = [factory mappingFromObject:sa];
    
    GHTestLog(@"%@", result);
    GHTestLog(@"%@", mapping3);
    
    GHAssertTrue([result isEqual:mapping3], @"[FAILURE] Expected(%@) got(%@) (Did not successfully retrieve subclass of TestObjectA)", mapping3, result);
}

@end
