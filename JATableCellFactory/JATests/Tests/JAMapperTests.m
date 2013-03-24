//
//  JAMapperTests.m
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


@interface JACellFactory (sneaky)

@property (nonatomic, strong) NSMutableArray *store;

@end

@interface JAMapperTests : GHTestCase

@end


@implementation JAMapperTests
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

- (void) testAddMappings
{
    BOOL didAddMapping = NO;
    
    JAObjectMapping *map = [JAObjectMapping mappingFromModelClass:[TestObjectA class] toCellClass:[UITableViewCell class]];
    didAddMapping  = [factory addObjectMapping:map];
    
    JAObjectMapping *map2 = [JAObjectMapping mappingFromModelClass:[TestObjectB class] toCellClass:[UITableViewCell class]];
    didAddMapping  = [factory addObjectMapping:map2];
    
    GHAssertTrue(didAddMapping && factory.store.count == 2, @"[FAILURE] Mapping was NOT added successfully.");
}

- (void) testAddMappingsClash
{
    BOOL didAddMapping = NO;
    
    JAObjectMapping *map = [JAObjectMapping mappingFromModelClass:[TestObjectA class] toCellClass:[UITableViewCell class]];
    didAddMapping  = [factory addObjectMapping:map];
    
    JAObjectMapping *map2 = [JAObjectMapping mappingFromModelClass:[TestObjectA class] toCellClass:[UITableViewCell class]];
    didAddMapping  = [factory addObjectMapping:map2];
    
    GHAssertTrue(!didAddMapping && factory.store.count == 1, @"[FAILURE] Mapping should of clashed and not added the same mapping rule.");
}

- (void) testCountMappings
{
    JAObjectMapping *map = [JAObjectMapping mappingFromModelClass:[TestObjectA class] toCellClass:[UITableViewCell class]];
    [factory addObjectMapping:map];
    
    JAObjectMapping *map2 = [JAObjectMapping mappingFromModelClass:[TestObjectB class] toCellClass:[UITableViewCell class]];
    [factory addObjectMapping:map2];
    
    JAObjectMapping *map3 = [JAObjectMapping mappingFromModelClass:[TestObjectA class] toCellClass:[UITableViewCell class]];
    [factory addObjectMapping:map3];
    
    GHTestLog(@"%@", factory.store);
    GHAssertTrue(factory.store.count == 2, @"[FAILURE] Expected 2 Mappings in store, revieved %d", factory.store.count);
    
}

@end
