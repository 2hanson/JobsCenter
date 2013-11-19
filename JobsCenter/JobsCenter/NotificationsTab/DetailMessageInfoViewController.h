//
//  DetailMessageInfoViewController.h
//  qeebuConference
//
//  Created by hanson on 10/5/12.
//  Copyright (c) 2012 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMessageInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *messageText;
@property (strong, nonatomic) NSString *detailMessageInfo;

@end

