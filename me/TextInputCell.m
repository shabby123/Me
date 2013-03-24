//
//  TextInputCell.m
//  me
//
//  Created by Joel Guedj on 2013-03-17.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import "TextInputCell.h"
#import "JGTextField.h"

@implementation TextInputCell

@synthesize textField;

- (id)initWithPlaceHolder:(NSString *) placeHolder reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        textField = [[JGTextField alloc]initWithFrame:CGRectMake(10, 5, 300, 32)];
        textField.background = [[UIImage imageNamed:@"textfield"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        textField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        textField.autoresizesSubviews = YES;

        [textField setBorderStyle:UITextBorderStyleNone];
        [textField setPlaceholder:placeHolder];

        textField.backgroundColor = [UIColor clearColor];
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        [self.contentView addSubview:textField];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
