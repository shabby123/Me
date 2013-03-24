//
//  ItemCell.m
//  me
//
//  Created by Joel Guedj on 2013-03-18.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import "ItemCell.h"
#import "Common.h"

@implementation ItemCell

@synthesize nameLabel;
@synthesize descriptionLabel;

- (id)initWithItemCellType:(ItemCellType) cellType reuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        int topMargin;
        switch (cellType) {
            case ItemCellTypeTop:
                topMargin = 8;
                break;
            case ItemCellTypeMiddle:
                topMargin = 5;
                break;
            case ItemCellTypeBottom:
                topMargin = 5;
                break;
            case ItemCellTypeSingle:
                topMargin = 8;
                break;
                
            default:
                break;
        }

        int margin = 30;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, topMargin, 360 - 2 * margin, 30)];
        [nameLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:17.0]];
        nameLabel.textColor = [Common colorWithHexString:@"060606"];
        nameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:nameLabel];
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, topMargin + 22, 360 - 2 * margin, 30)];
        [descriptionLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:13.0]];
        descriptionLabel.textColor = [Common colorWithHexString:@"7f7f7f"];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:descriptionLabel];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
