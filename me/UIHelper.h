//
//  UIHelper.h
//  me
//
//  Created by Joel Guedj on 2013-03-16.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIHelper : NSObject

+ (void) setupAppearance;

+ (UIBarButtonItem *) addButtonForTarget:(id) target andSelector:(SEL) selector;
+ (UIBarButtonItem *) cancelButtonForTarget:(id) target andSelector:(SEL) selector;
+ (UIBarButtonItem *) saveButtonForTarget:(id) target andSelector:(SEL) selector;

@end
