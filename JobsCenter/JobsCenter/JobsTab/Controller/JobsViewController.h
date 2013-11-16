//
//  JobsViewController.h
//  JobsCenter
//
//  Created by hanson on 11/16/13.
//  Copyright (c) 2013 Jobs. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"

@interface JobsViewController : UITableViewController <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>{
	
	EGORefreshTableHeaderView *_refreshHeaderView;
    
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
}

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
