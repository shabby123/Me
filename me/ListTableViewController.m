//
//  ListTableViewController.m
//  Me
//
//  Created by Joel Guedj on 2013-02-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import "ListTableViewController.h"
#import "CoreDataStore.h"
#import "UIHelper.h"
#import "ItemCell.h"

@interface ListTableViewController () {
    NSMutableArray *items;
}

- (void) showAddItemTableViewController;
- (void) saveDisplayOrder;
- (BOOL) isRootView;
- (NSString *) parentId;

@end

@implementation ListTableViewController

@synthesize parentItem;

- (void) showAddItemTableViewController {
    AddItemTableViewController *addItemTableViewController = [[AddItemTableViewController alloc] initWithStyle:UITableViewStylePlain];
    addItemTableViewController.parentItem = parentItem;
    addItemTableViewController.delegate = self;
    
    UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:addItemTableViewController];

    [self presentViewController:modalNavigationController animated:YES completion:nil];
}

- (void) saveDisplayOrder {
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[CoreDataStore sharedClient] setDisplayOrder:idx forItemWithId:[obj id]];
    }];
    
    // setDisplayOrderforItemWithId wont save so we have to do it.
    [[CoreDataStore sharedClient] save];
}

- (BOOL) isRootView {
    if (parentItem == nil) {
        return YES;
    }
    
    return NO;
}

- (NSString *) parentId {
    if ([self isRootView]) {
        return @"root";
    }

    return [parentItem id];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.navigationItem.rightBarButtonItem = [UIHelper addButtonForTarget:self andSelector:@selector(showAddItemTableViewController)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    items = [[[CoreDataStore sharedClient] itemsWithParentId:[self parentId]] mutableCopy];

    self.tableView.allowsSelectionDuringEditing = YES;
    //[self setEditing:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self isRootView]) {
        return 1;
    }
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self isRootView] || section == 1) {
        return [items count];
    }
    
    return 1;
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isRootView] || indexPath.section == 1) {
        //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        /*MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
        {
            cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        [cell setDelegate:self];
        [cell setFirstStateIconName:@"check.png"
                         firstColor:[UIColor colorWithRed:85.0/255.0 green:213.0/255.0 blue:80.0/255.0 alpha:1.0]
                secondStateIconName:@"cross.png"
                        secondColor:[UIColor colorWithRed:232.0/255.0 green:61.0/255.0 blue:14.0/255.0 alpha:1.0]
                      thirdIconName:@"clock.png"
                         thirdColor:[UIColor colorWithRed:254.0/255.0 green:217.0/255.0 blue:56.0/255.0 alpha:1.0]
                     fourthIconName:@"list.png"
                        fourthColor:[UIColor colorWithRed:206.0/255.0 green:149.0/255.0 blue:98.0/255.0 alpha:1.0]];
        */
        
        ItemCell *cell;
        ItemCellType cellType;
        if (indexPath.row == 0 && items.count == 1) {
            cellType = ItemCellTypeSingle;
        }
        else if (indexPath.row == 0) {
            cellType = ItemCellTypeTop;
        }
        else if (indexPath.row < (items.count - 1) && items.count > 2) {
            cellType = ItemCellTypeMiddle;
        }
        else {
            cellType = ItemCellTypeBottom;
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:[UIHelper nameOfCellType:cellType]];
        if (!cell) {
            cell = [UIHelper cellWithType:cellType];
        }
        
        // Configure the cell...
        cell.nameLabel.text = [[items objectAtIndex:(NSUInteger) indexPath.row] name];
        cell.descriptionLabel.text = @"This is the description of the cell";
        
        cell.delegate = self;
        
        return cell;
    }

    // This is the top cell, containing information about the level we are on right now
    static NSString *CellIdentifier = @"ParentItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.contentView.backgroundColor = [UIColor clearColor];
        
    }
    
    // Configure the cell...
    cell.textLabel.text = parentItem.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Item *itemToMove = [items objectAtIndex:(NSUInteger) fromIndexPath.row];
    [items removeObjectAtIndex:(NSUInteger) fromIndexPath.row];
    [items insertObject:itemToMove atIndex: (NSUInteger) toIndexPath.row];
    
    [self saveDisplayOrder];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isRootView] || indexPath.section == 1) {
        return YES;
    }
    
    return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    // Prevent the user from moving the row to another section
    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
        NSInteger row = 0;
        if (sourceIndexPath.section < proposedDestinationIndexPath.section) {
            row = [tableView numberOfRowsInSection:sourceIndexPath.section] - 1;
        }
        return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];
    }
    
    /*if (!isMovingRow) {
        isMovingRow = true;
        previousProposedDestinationIndexPath = [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row inSection:proposedDestinationIndexPath.section];
    }
    
    NSIndexPath *tmpProposedDestinationIndexPath;
    NSIndexPath *tmpSourceDestinationIndexPath;
    if ((previousProposedDestinationIndexPath != nil) && (sourceIndexPath.row == proposedDestinationIndexPath.row)) {
        tmpProposedDestinationIndexPath = previousProposedDestinationIndexPath;
        tmpSourceDestinationIndexPath = sourceIndexPath;

    }
    else {
        tmpSourceDestinationIndexPath = sourceIndexPath;
        tmpProposedDestinationIndexPath = proposedDestinationIndexPath;
    }
    
    
    NSLog(@"---------");
    NSLog(@"Source: %ld Dest: %ld", (long)tmpSourceDestinationIndexPath.row, (long)tmpProposedDestinationIndexPath.row);
    */
    // Update the cells background images
    [UIHelper
     updateBackgroundImageForCellInTableView:tableView
     targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath
     toProposedIndexPath:proposedDestinationIndexPath];

    return proposedDestinationIndexPath;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isRootView] || indexPath.section == 1) {
        ListTableViewController *listTableViewController = [[ListTableViewController alloc] initWithStyle:UITableViewStylePlain];
        listTableViewController.parentItem = [items objectAtIndex:(NSUInteger) indexPath.row];

        [self.navigationController pushViewController:listTableViewController animated:YES];
    }
}

#pragma mark - MCSwipeTableViewCellDelegate

- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didTriggerState:(MCSwipeTableViewCellState)state withMode:(MCSwipeTableViewCellMode)mode
{    
    if (mode == MCSwipeTableViewCellModeExit)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        // Delete the row from the data source
        [[CoreDataStore sharedClient] deleteItemWithId:[[items objectAtIndex:(NSUInteger) indexPath.row] id]];
        [items removeObjectAtIndex:(NSUInteger) indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self saveDisplayOrder];
    }
}

#pragma mark - AddItemTableViewControllerDelegate

- (void)addItemViewController:(AddItemTableViewController *)controller addedItem:(Item *)item {
    int section = [self isRootView] ? 0 : 1;

    int nextIndex = items.count;
    
    item.displayOrder = nextIndex;
    [[CoreDataStore sharedClient] putItem:item forParentItemWithId:[self parentId]];
    [items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nextIndex inSection:section];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void) addItemViewControllerDidCancel:(AddItemTableViewController *)controller {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
