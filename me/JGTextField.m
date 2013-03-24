//
//  JGTextField.m
//  me
//
//  Created by Joel Guedj on 2013-03-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import "JGTextField.h"

const int InsetLeft = 10;
const int InsetTop = 5;

@implementation JGTextField

// Placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, InsetLeft, InsetTop);
}

// Text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, InsetLeft, InsetTop);
}

@end
