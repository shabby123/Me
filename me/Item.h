//
//  Item.h
//  Me
//
//  Created by Joel Guedj on 2013-02-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) int displayOrder;

@end
