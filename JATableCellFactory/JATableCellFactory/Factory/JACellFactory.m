//
//  JACellFactory.m
//  JATableCellFactory
//
//  Created by John Hatvani on 24/03/13.
//  Copyright (c) 2013 electric-mind. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JACellFactory.h"

#import "JAObjectMapping.h"
#import "JACell.h"

static JACellFactory *_instance;
@interface JACellFactory ()

@property(nonatomic, strong) NSMutableSet *store;

@end

@implementation JACellFactory

#pragma mark - initializer

+ (JACellFactory *) getInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(_instance == nil)
        {
            _instance = [[JACellFactory alloc] init];
        }
    });
    
    
    return _instance;
}

- (id) init
{
    @synchronized(self)
    {
        self = [super init];
        if(self)
        {
            self.store = [[NSMutableSet alloc] init];
        }
        return self;
    }
}

#pragma mark - public
#pragma mark add mapping

- (BOOL) addObjectMapping:(JAObjectMapping *)m
{
    if(![self.store containsObject:m])
    {
        [self.store addObject:m];
        return YES;
    }
    
    return NO;
}

#pragma mark cell factory

- (Class) cellClassFromObject:(id)object
{
    JAObjectMapping *mapping = [self mappingFromObject:object];
    return mapping.cellClass;
}

- (UITableViewCell *) cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath fromTableView:(UITableView *)tableview
{
    JAObjectMapping *mapping = [self mappingFromObject:object];
    
    NSString *identifier  = NSStringFromClass(mapping.cellClass);
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    NSString *nibName     = [(Class<JACell>)mapping.cellClass nibNameForCellOrNil];
    
    if(!cell)
    {
        if(nibName != nil)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:nibName owner:cell options:nil][0];
        }
        else
        {
            cell = [[mapping.cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
    }
    
    if([cell respondsToSelector:@selector(updateCellWithObject:atIndexPath:)])
    {
        [(UITableViewCell <JACell> *)cell updateCellWithObject:object atIndexPath:indexPath];
    }
    
    return cell;
}


#pragma mark - private

- (JAObjectMapping *) mappingFromObject:(NSObject *)object
{
    __block JAObjectMapping *mapping = nil;
    [self.store enumerateObjectsUsingBlock:^(JAObjectMapping *obj, BOOL *stop) {
        
        if([obj.objectClass hash] == [object.class hash])
        {
            *stop   = YES;
            mapping = obj;
        }
        
    }];
    
    return mapping;
}

@end
