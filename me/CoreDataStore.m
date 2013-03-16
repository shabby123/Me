//
//  CoreDataStore.m
//  Me
//
//  Created by Joel Guedj on 2013-02-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import "CoreDataStore.h"
#import "ItemDataModel.h"

@interface CoreDataStore()

- (id) createObjectOfType:(NSString *) type;
- (id) entity:(NSString *) entityName with:(NSString *) predicateString equalTo:(NSString *) comparatorString;
- (ItemDataModel *) itemDataModelWithId:(NSString *)id;

@end

@implementation CoreDataStore

#pragma mark Item
- (void) createRootItem {
    ItemDataModel *rootItemDataModel = [self itemDataModelWithId:@"root"];
    if (!rootItemDataModel) {
        rootItemDataModel = [self createObjectOfType:@"ItemDataModel"];
        
        rootItemDataModel.id = @"root";
        
        [self save];
    }

}

- (void) putItem:(Item *) item forParentItemWithId:(NSString *) id {
    // Try to find the parent item
    ItemDataModel *parentItemDataModel = [self itemDataModelWithId:id];
    if (parentItemDataModel) {
        // Try to get item first
        ItemDataModel *itemDataModel = [self itemDataModelWithId:item.id];
        if (!itemDataModel) {
            // Item does not exist in data store, create it
            itemDataModel = [self createObjectOfType:@"ItemDataModel"];
        }
        
        // Update the item
        itemDataModel.id = item.id;
        itemDataModel.name = item.name;
        itemDataModel.displayOrder = [NSNumber numberWithInt:item.displayOrder];
        itemDataModel.parent = parentItemDataModel;
        
        // Set this item as child to parent
        [parentItemDataModel addChildrenObject:itemDataModel];
        
        [self save];
    }
}

- (NSArray *) itemsWithParentId:(NSString *) parentId {
    NSMutableArray *childItems = [NSMutableArray array];
    ItemDataModel *itemDataModel = [self itemDataModelWithId:parentId];
    
    // Sort items on displayOrder
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayOrder" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    //NSSet *itemDataModels = [itemDataModel children];
    NSArray *itemDataModels = [[itemDataModel children] sortedArrayUsingDescriptors:sortDescriptors];
    
    [itemDataModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ItemDataModel *childItemDataModel = (ItemDataModel *)obj;
        
        Item *childItem = [[Item alloc] init];
        childItem.id = childItemDataModel.id;
        childItem.name = childItemDataModel.name;
        childItem.displayOrder = childItemDataModel.displayOrder.intValue;
        
        [childItems addObject:childItem];
    }];
    
    return childItems;
}

- (void) setDisplayOrder:(int) displayOrder forItemWithId:(NSString *) id {
    ItemDataModel *itemDataModel = [self itemDataModelWithId:id];
    itemDataModel.displayOrder = [NSNumber numberWithInt:displayOrder];
    
    // Do not save here, let the user do it
}

- (void) deleteItemWithId:(NSString *) id {
    ItemDataModel *itemDataModel = [self itemDataModelWithId:id];
    if (itemDataModel) {
        [self delete:itemDataModel];
        [self save];
    }
}

#pragma mark private methods

- (id) createObjectOfType:(NSString *) type {
    return [NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:_managedObjectContext];
}

- (id) entity:(NSString *) entityName with:(NSString *) predicateString equalTo:(NSString *) comparatorString {
    if (entityName && predicateString && comparatorString) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        
        // Set predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@", predicateString, comparatorString];
        [request setPredicate:predicate];
        
        NSError *error;
        NSArray *array = [_managedObjectContext executeFetchRequest:request error:&error];
        if (array == nil || [array count] == 0)
        {
            //NSLog(@"Could not find %@ with predicate %@ and comparator %@", entityName, predicateString, comparatorString);
            return nil;
        }
        
        return [array objectAtIndex:0];
    }
    
    return nil;
}

- (ItemDataModel *) itemDataModelWithId:(NSString *)id {
    return [self entity:@"ItemDataModel" with:@"id" equalTo:id];
}

#pragma mark CoreDataStore

- (void) save {
    // Commit
    NSError *error;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error while trying to save object");
    }
}

- (void) delete:(NSManagedObject *)object {
    [_managedObjectContext deleteObject:object];
}

- (void) setManagedObjectContext:(NSManagedObjectContext *) context {
    // Set up managed object context
    _managedObjectContext = context;
}

+ (CoreDataStore *)sharedClient {
    static CoreDataStore *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CoreDataStore alloc] init];
    });
    
    return _sharedClient;
}

@end
