//
//  JACellFactory.h
//  JATableCellFactory
//
//  Created by John Hatvani on 24/03/13.
//  Copyright (c) 2013 electric-mind. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JAObjectMapping;
@interface JACellFactory : NSObject

+ (JACellFactory *) getInstance;

- (BOOL) addObjectMapping:(JAObjectMapping *)mapping;

- (UITableViewCell *) cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath fromTableView:(UITableView *)tableview;

- (Class) cellClassFromObject:(id)object;

@end
