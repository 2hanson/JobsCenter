//
//  NotificationsTableCell.h
//  JobsCenter
//
//  Created by hanson on 11/19/13.
//  Copyright (c) 2013 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsTableCell : UITableViewCell

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *messageTimeLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *messageContentLabel;

@end
