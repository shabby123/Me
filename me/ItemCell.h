//
//  ItemCell.h
//  me
//
//  Created by Joel Guedj on 2013-03-18.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSwipeTableViewCell.h"

@interface ItemCell : MCSwipeTableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;

typedef enum {
    ItemCellTypeSingle,
    ItemCellTypeTop,
    ItemCellTypeBottom,
    ItemCellTypeMiddle,
} ItemCellType;

- (id)initWithItemCellType:(ItemCellType) cellType reuseIdentifier:(NSString *)reuseIdentifier;

@end
