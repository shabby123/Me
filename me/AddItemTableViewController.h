//
//  AddItemTableViewController.h
//  Me
//
//  Created by Joel Guedj on 2013-02-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@class AddItemTableViewController;

@protocol AddItemTableViewControllerDelegate <NSObject>

- (void)addItemViewController:(AddItemTableViewController *) controller addedItem:(Item *)item;
- (void)addItemViewControllerDidCancel:(AddItemTableViewController *) controller;

@end

@interface AddItemTableViewController : UITableViewController

@property (nonatomic, strong) Item *parentItem;
@property (nonatomic, weak) id<AddItemTableViewControllerDelegate> delegate;

@end
