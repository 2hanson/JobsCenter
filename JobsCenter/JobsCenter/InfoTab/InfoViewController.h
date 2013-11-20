//
//  InfoViewController.h
//  JobsCenter
//
//  Created by hanson on 11/19/13.
//  Copyright (c) 2013 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EnLoadingMoreView.h"

@interface InfoViewController : UIViewController<EnLoadingMoreViewDelegate, EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource> {
    // 下拉刷新以及上拉更多相关
    EGORefreshTableHeaderView* _refreshHeaderView;
	BOOL _reloading;
    BOOL _isHasMore;
    EnLoadingMoreView* _loadingMoreView;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedTitle;

@property (strong, nonatomic) IBOutlet UITableView *tableInfos;

@end
