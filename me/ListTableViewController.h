//
//  ListTableViewController.h
//  Me
//
//  Created by Joel Guedj on 2013-02-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemTableViewController.h"
#import "MCSwipeTableViewCell.h"
#import "Item.h"

@interface ListTableViewController : UITableViewController<AddItemTableViewControllerDelegate, MCSwipeTableViewCellDelegate>

@property (nonatomic, strong) Item *parentItem;

@end
