//
//  JobsViewController.h
//  JobsCenter
//
//  Created by hanson on 11/16/13.
//  Copyright (c) 2013 Jobs. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "EnLoadingMoreView.h"

@interface GuidanceViewController : UITableViewController <EnLoadingMoreViewDelegate, EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    // 下拉刷新以及上拉更多相关
    EGORefreshTableHeaderView* _refreshHeaderView;
	BOOL _reloading;
    BOOL _isHasMore;
    EnLoadingMoreView* _loadingMoreView;
}

@end
