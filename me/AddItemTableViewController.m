//
//  AddItemTableViewController.m
//  Me
//
//  Created by Joel Guedj on 2013-02-24.
//  Copyright (c) 2013 duochjagochpensionarerna. All rights reserved.
//

#import "AddItemTableViewController.h"
#import "Common.h"
#import "UIHelper.h"

@interface AddItemTableViewController ()

- (void) cancel;
- (void) save;

@end

@implementation AddItemTableViewController

@synthesize parentItem;
@synthesize delegate;
@synthesize itemNameTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.navigationItem.leftBarButtonItem = [UIHelper cancelButtonForTarget:self andSelector:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [UIHelper saveButtonForTarget:self andSelector:@selector(save)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        // Name text field
        cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
        
    }
    else if (indexPath.row == 1) {
        // Description text field
        cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionCell"];
    }
    else if (indexPath.row == 2) {
        // Add photo
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddPhotoCel"];
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) save {
    if ([itemNameTextField.text length] == 0) {
        // TODO: Present error
    }
    else {
        Item *item = [[Item alloc] init];
        item.id = [Common generateGuid];
        item.name = itemNameTextField.text;
        
        [delegate addItemViewController:self addedItem:item];
    }
}

- (void) cancel {
    [delegate addItemViewControllerDidCancel:self];
}

@end
