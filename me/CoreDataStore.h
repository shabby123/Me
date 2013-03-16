//
//  CoreDataStore.h
//  Me
//
//  Created by Joel Guedj on 2013-02-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface CoreDataStore : NSObject {
    NSManagedObjectContext *_managedObjectContext;
}

#pragma mark Item
- (void) createRootItem;
- (void) putItem:(Item *) item forParentItemWithId:(NSString *) id;
- (NSArray *) itemsWithParentId:(NSString *) parentId;
- (void) setDisplayOrder:(int) displayOrder forItemWithId:(NSString *) id;
- (void) deleteItemWithId:(NSString *) id;

# pragma mark CoreDataStore
- (void) save;
- (void) setManagedObjectContext:(NSManagedObjectContext *) context;
+ (CoreDataStore *)sharedClient;

@end
