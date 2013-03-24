//
//  UIHelper.m
//  me
//
//  Created by Joel Guedj on 2013-03-16.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+ (void) setupAppearance {
    // Setup headers
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // Setup table views
    // TODO: NOT WORKING!
    //[[UITableView appearance] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
}

+ (UIBarButtonItem *) addButtonForTarget:(id) target andSelector:(SEL) selector {
    UIImage *addButtonImage = [[UIImage imageNamed:@"bluebutton"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:target action:selector];
    [addButton setBackgroundImage:addButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    return addButton;
}

+ (UIBarButtonItem *) cancelButtonForTarget:(id) target andSelector:(SEL) selector {
    UIImage *cancelButtonImage = [[UIImage imageNamed:@"whitebutton"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:target action:selector];
    [cancelButton setBackgroundImage:cancelButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    //[cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor blackColor], nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor, nil]] forState:UIControlStateNormal];
    [cancelButton setTitleTextAttributes:
            @{
                    UITextAttributeTextColor : [UIColor blackColor],
                    UITextAttributeTextShadowColor : [UIColor whiteColor]
            }
                                forState:UIControlStateNormal];

    return cancelButton;
}

+ (UIBarButtonItem *) saveButtonForTarget:(id) target andSelector:(SEL) selector {
    UIImage *saveButtonImage = [[UIImage imageNamed:@"bluebutton"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:target action:selector];
    [saveButton setBackgroundImage:saveButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    return saveButton;
}

+ (UIImage *) imageForCellType:(ItemCellType) cellType {
    UIImage *image;
    switch (cellType) {
        case ItemCellTypeTop:
            image = [[UIImage imageNamed:[UIHelper nameOfCellType:cellType]] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 14, 1, 14)];
            break;
        case ItemCellTypeMiddle:
            image = [[UIImage imageNamed:[UIHelper nameOfCellType:cellType]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 1, 14)];
            break;
        case ItemCellTypeBottom:
            image = [[UIImage imageNamed:[UIHelper nameOfCellType:cellType]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 6, 14)];
            break;
        case ItemCellTypeSingle:
            image = [[UIImage imageNamed:[UIHelper nameOfCellType:cellType]] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 14, 6, 14)];
            break;
        default:
            break;
    }
    
    return image;
}

+ (ItemCell *) cellWithType:(ItemCellType) cellType {
    ItemCell *cell = [[ItemCell alloc] initWithItemCellType:cellType reuseIdentifier:[UIHelper nameOfCellType:cellType]];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    UIImage *backgroundImage = [self imageForCellType:cellType];
    cell.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    //[cell.contentView addSubview:[[UIImageView alloc] initWithImage:backgroundImage]];

    cell.nameLabel.backgroundColor = [UIColor clearColor];
    cell.descriptionLabel.backgroundColor = [UIColor clearColor];
    
    // We need to provide the icon names and the desired colors
    [cell setFirstStateIconName:@"check.png"
                     firstColor:[UIColor colorWithRed:85.0/255.0 green:213.0/255.0 blue:80.0/255.0 alpha:1.0]
            secondStateIconName:@"cross.png"
                    secondColor:[UIColor colorWithRed:232.0/255.0 green:61.0/255.0 blue:14.0/255.0 alpha:1.0]
                  thirdIconName:@"clock.png"
                     thirdColor:[UIColor colorWithRed:254.0/255.0 green:217.0/255.0 blue:56.0/255.0 alpha:1.0]
                 fourthIconName:@"list.png"
                    fourthColor:[UIColor colorWithRed:206.0/255.0 green:149.0/255.0 blue:98.0/255.0 alpha:1.0]];
    
    // We need to set a background to the content view of the cell
    //[cell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    // Setting the type of the cell
    [cell setMode:MCSwipeTableViewCellModeExit];
    
    return cell;
}

+ (NSString *) nameOfCellType:(ItemCellType) cellType {
    switch (cellType) {
        case ItemCellTypeTop:
            return @"topcell";
            break;
        case ItemCellTypeMiddle:
            return @"middlecell";
            break;
        case ItemCellTypeBottom:
            return @"bottomcell";
            break;
        case ItemCellTypeSingle:
            return @"singlecell";
        default:
            return nil;
    }
}

+ (void) updateBackgroundImageForCellInTableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {

    
    /*for (NSIndexPath* visibleIndexPath in tableView.indexPathsForVisibleRows) {
        UITableViewCell* visibleCell = [tableView cellForRowAtIndexPath:visibleIndexPath];
        if (visibleIndexPath.row == 0) {
            ((UIImageView *)visibleCell.backgroundView).image = [self imageForCellType:ItemCellTypeTop];
        }
        else if (visibleIndexPath.row == [tableView numberOfRowsInSection:visibleIndexPath.section]) {
            ((UIImageView *)visibleCell.backgroundView).image = [self imageForCellType:ItemCellTypeBottom];
        }
        else  {
            ((UIImageView *)visibleCell.backgroundView).image = [self imageForCellType:ItemCellTypeMiddle];
        }
    }*/
    
    /*NSInteger sectionRows = [tableView numberOfRowsInSection:[sourceIndexPath section]];
    
    UITableViewCell *sourceCell = [tableView cellForRowAtIndexPath:sourceIndexPath];
    UITableViewCell *destCell = [tableView cellForRowAtIndexPath:proposedDestinationIndexPath];
    
    NSLog(@"Source: %@ Dest: %@", ((ItemCell *)sourceCell).nameLabel.text, ((ItemCell *)destCell).nameLabel.text);
    NSLog(@"First: %@ Second: %@", ((ItemCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]]).nameLabel.text, ((ItemCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]]).nameLabel.text);
    
    if(sourceIndexPath.row == 0 && proposedDestinationIndexPath.row == 1)
    {
        NSLog(@"Set ItemCellTypeTop for %@", ((ItemCell *)destCell).nameLabel.text);
        ((UIImageView *)destCell.backgroundView).image = [self imageForCellType:ItemCellTypeTop];
        
        if(proposedDestinationIndexPath.row == sectionRows - 1) {
            NSLog(@"Set ItemCellTypeBottom for %@", ((ItemCell *)sourceCell).nameLabel.text);
            ((UIImageView *)sourceCell.backgroundView).image = [self imageForCellType:ItemCellTypeBottom];
        }
        else {
                        NSLog(@"Set ItemCellTypeMiddle for %@", ((ItemCell *)sourceCell).nameLabel.text);
            ((UIImageView *)sourceCell.backgroundView).image = [self imageForCellType:ItemCellTypeMiddle];
        }
    }
    else if(sourceIndexPath.row == sectionRows - 1 && proposedDestinationIndexPath.row == sectionRows - 2)
    {
        NSLog(@"Set ItemCellTypeBottom for %@", ((ItemCell *)destCell).nameLabel.text);
        ((UIImageView *)destCell.backgroundView).image = [self imageForCellType:ItemCellTypeBottom];
        
        if(proposedDestinationIndexPath.row == 0) {
            NSLog(@"Set ItemCellTypeTop for %@", ((ItemCell *)sourceCell).nameLabel.text);
            ((UIImageView *)sourceCell.backgroundView).image = [self imageForCellType:ItemCellTypeTop];
        }
        else {
            NSLog(@"Set ItemCellTypeMiddle for %@", ((ItemCell *)sourceCell).nameLabel.text);
            ((UIImageView *)sourceCell.backgroundView).image = [self imageForCellType:ItemCellTypeMiddle];
        }
    }
    else if(proposedDestinationIndexPath.row == 0)
    {
        NSLog(@"Set ItemCellTypeTop for %@", ((ItemCell *)sourceCell).nameLabel.text);
        ((UIImageView *)sourceCell.backgroundView).image = [self imageForCellType:ItemCellTypeTop];
        
        destCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:proposedDestinationIndexPath.section]];
        if(sectionRows == 2) {
                    NSLog(@"Set ItemCellTypeBottom for %@", ((ItemCell *)destCell).nameLabel.text);
            ((UIImageView *)destCell.backgroundView).image = [self imageForCellType:ItemCellTypeBottom];
        }
        else {
                    NSLog(@"Set ItemCellTypeMiddle for %@", ((ItemCell *)destCell).nameLabel.text);
            ((UIImageView *)destCell.backgroundView).image = [self imageForCellType:ItemCellTypeMiddle];
        }
    }
    else if(proposedDestinationIndexPath.row == sectionRows - 1)
    {
                NSLog(@"Set ItemCellTypeBottom for %@", ((ItemCell *)sourceCell).nameLabel.text);
        ((UIImageView *)sourceCell.backgroundView).image = [self imageForCellType:ItemCellTypeBottom];
        
        destCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sectionRows - 1 inSection:proposedDestinationIndexPath.section]];
        if(sectionRows == 2) {
                    NSLog(@"Set ItemCellTypeTop for %@", ((ItemCell *)destCell).nameLabel.text);
            ((UIImageView *)destCell.backgroundView).image = [self imageForCellType:ItemCellTypeTop];
        }
        else {
                    NSLog(@"Set ItemCellTypeMiddle for %@", ((ItemCell *)destCell).nameLabel.text);
            ((UIImageView *)destCell.backgroundView).image = [self imageForCellType:ItemCellTypeMiddle];
        }
    }*/
}

+ (TextInputCell *) nameCell {
    return [[TextInputCell alloc] initWithPlaceHolder:@"Name" reuseIdentifier:@"NameCell"];
}

+ (TextInputCell *) descriptionCell {
    return [[TextInputCell alloc] initWithPlaceHolder:@"Description" reuseIdentifier:@"DescriptionCell"];
}

+ (UITableViewCell *) addPhotoCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddPhotoCell"];
    
    cell.textLabel.text = @"Add photo";
    
    return cell;
}


@end
