//
//  DetailMessageInfoViewController.m
//  qeebuConference
//
//  Created by hanson on 10/5/12.
//  Copyright (c) 2012 com. All rights reserved.
//

#import "DetailMessageInfoViewController.h"

@interface DetailMessageInfoViewController ()

@end

@implementation DetailMessageInfoViewController

@synthesize detailMessageInfo;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.messageText.text = self.detailMessageInfo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMessageText:nil];
    [super viewDidUnload];
}
@end
