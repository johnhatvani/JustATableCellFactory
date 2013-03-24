//
//  JACell.h
//  JATableCellFactory
//
//  Created by John Hatvani on 24/03/13.
//  Copyright (c) 2013 electric-mind. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol JACell <NSObject>

@required

- (void) updateCellWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
+ (CGFloat) heightFromObject:(id)object atIndexPath:(NSIndexPath *)indexPath;
+ (NSString *)nibNameForCellOrNil;

@end
