//
//  JAObjectMapping.h
//  JATableCellFactory
//
//  Created by John Hatvani on 24/03/13.
//  Copyright (c) 2013 electric-mind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JAObjectMapping : NSObject

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) Class objectClass;

+ (JAObjectMapping *) mappingFromModelClass:(Class)objectClass toCellClass:(Class)cellClass;

@end
