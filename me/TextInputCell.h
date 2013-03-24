//
//  TextInputCell.h
//  me
//
//  Created by Joel Guedj on 2013-03-17.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextInputCell : UITableViewCell

@property (strong, nonatomic) UITextField *textField;

- (id)initWithPlaceHolder:(NSString *) placeHolder reuseIdentifier:(NSString *)reuseIdentifier;

@end
