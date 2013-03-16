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
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header"] forBarMetrics:UIBarMetricsDefault];
}

+ (UIBarButtonItem *) addButtonForTarget:(id) target andSelector:(SEL) selector {
    return [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:target action:selector];
}

+ (UIBarButtonItem *) cancelButtonForTarget:(id) target andSelector:(SEL) selector {
    return [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:target action:selector];
}

+ (UIBarButtonItem *) saveButtonForTarget:(id) target andSelector:(SEL) selector {
    return [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:target action:selector];
}

@end
