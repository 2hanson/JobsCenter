//
//  InfoViewController.m
//  JobsCenter
//
//  Created by hanson on 11/19/13.
//  Copyright (c) 2013 Jobs. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize tableInfos;
@synthesize segmentedTitle;

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
	// Do any additional setup after loading the view.
    //为了让下拉刷新能正常工作,http://www.cocoachina.com/bbs/simple/?t154091.html
    /*self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;*/
    
	if (_refreshHeaderView == nil) {
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableInfos.bounds.size.height, self.view.frame.size.width, self.tableInfos.bounds.size.height)];
		_refreshHeaderView.delegate = self;
		[self.tableInfos addSubview:_refreshHeaderView];
        
	}
    
    if (_loadingMoreView == nil) {
		_loadingMoreView = [[EnLoadingMoreView alloc] initWithFrame:CGRectZero];
        _loadingMoreView.loadingMoreDelegate = self;
        [self.tableInfos addSubview:_loadingMoreView];
		
	}
    
    //加载数据
    _isHasMore = YES;
    _reloading = YES;
    [_refreshHeaderView setLoadingStateWithScrollView:self.tableInfos];
    
    //
    [self.segmentedTitle addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentAction:(id)sender
{
    //加载数据
    _isHasMore = YES;
    _reloading = YES;
    [_refreshHeaderView setLoadingStateWithScrollView:self.tableInfos];
    //[self.newsView reloadType:self.segment_title.selectedSegmentIndex+1];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    return cell;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadingMoreView enLoadingMoreScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark 重新将数据加载到view的方法
- (void)doneLoadingReloadData {
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInfos];
    [_loadingMoreView enLoadingMoreScrollViewDataSourceDidFinishedLoading:self.tableInfos]; // 这个状态会更改loading moreview 的位置
    _reloading = NO;
}
- (void)doneLoadingMoreData {
    [_loadingMoreView enLoadingMoreScrollViewDataSourceDidFinishedLoading:self.tableInfos];
    _reloading = NO;
}

#pragma mark -
#pragma mark ENLoadingMoreView Delegate
- (BOOL)enLoadingMoreViewDataSourceHasMore:(EnLoadingMoreView *)view {
    return _isHasMore;
}

- (BOOL)enLoadingMoreViewDataSourceIsLoading:(EnLoadingMoreView *)view {
    return _reloading;
}

- (void)enLoadingMoreViewTriggerRefresh:(EnLoadingMoreView *)view {
    _reloading = YES;
    [self performSelector:@selector(doneLoadingMoreData) withObject:nil afterDelay:1.0];
    //[self performSelectorInBackground:@selector(loadingMoreDataRequest) withObject:nil]; // 在子线程中请求数据
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
	_reloading = YES;
    [self performSelector:@selector(doneLoadingReloadData) withObject:nil afterDelay:1.0];
    //[self performSelectorInBackground:@selector(reloadDataRequest) withObject:nil]; // 在子线程中请求数据
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return nil; // should return date data source was last changed
}

@end
