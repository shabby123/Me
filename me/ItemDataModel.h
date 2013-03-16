//
//  ItemDataModel.h
//  me
//
//  Created by Joel Guedj on 2013-03-13.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemDataModel;

@interface ItemDataModel : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *children;
@property (nonatomic, retain) ItemDataModel *parent;
@end

@interface ItemDataModel (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(ItemDataModel *)value;
- (void)removeChildrenObject:(ItemDataModel *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;

@end
