//
//  NotificationsViewController.m
//  JobsCenter
//
//  Created by hanson on 11/19/13.
//  Copyright (c) 2013 Jobs. All rights reserved.
//

#import "NotificationsViewController.h"
#import "NotificationsTableCell.h"
#import "DetailMessageInfoViewController.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

#define STR(A,B) [NSString stringWithFormat:@"%@",[A objectForKey:@B]]

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadMessages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.listMessagess count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* NotificationsTableCellIdentifier = @"NotificationsTableCellIdentifier";
    
    NotificationsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                       NotificationsTableCellIdentifier];
    if (cell == nil) {
        NSArray *ibs = [[NSBundle mainBundle] loadNibNamed:@"NotificationsTableCell"
                                                     owner:self options:nil];
        cell = [ibs objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger row = [indexPath row];
    NSDictionary *dict=[self.listMessagess objectAtIndex:row];
    NSString *messageContent = STR(dict,"message");
    NSString* messageTime = STR(dict, "messageTime");
    
    cell.messageTimeLabel.text = messageTime;
    cell.messageContentLabel.text = messageContent;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailMessageInfoViewController *messageDetailInfoVC = [[DetailMessageInfoViewController alloc] initWithNibName:@"DetailMessageInfoView" bundle:nil];
    NSUInteger row = [indexPath row];
    
    NSDictionary *dict=[self.listMessagess objectAtIndex:row];
    NSString *messagecontent = STR(dict,"message");
    
    messageDetailInfoVC.detailMessageInfo = messagecontent;
    [self.navigationController pushViewController:messageDetailInfoVC animated:YES];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void) loadMessages
{
    self.listMessagess=nil;
    NSMutableArray *rs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; ++i) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        for (int index = 0; index < 2; ++index)
        {
            id columnName = @"message";//[dbHelper columnName:statement columnIndex:index];
			id columnData = @"hello world";//[dbHelper columnData:statement columnIndex:index];
            //NSLog(@"%@", [columnName string]);
			//rchf 2011-1-20
            if (index == 1) {
                columnName = @"messageTime";
                columnData = @"2011-1-20";
            }
			if(columnData!=nil&&columnName!=nil)
            {
                [dictionary setObject:columnData forKey:columnName];
            }
            
        }
        
        [rs addObject:dictionary];
    }
    
    self.listMessagess = [rs copy];
}

@end
