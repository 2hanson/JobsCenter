//
//  JobsViewController.m
//  JobsCenter
//
//  Created by hanson on 11/16/13.
//  Copyright (c) 2013 Jobs. All rights reserved.
//

#import "StrategyViewController.h"

@interface StrategyViewController ()

@end

@implementation StrategyViewController

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
    //为了让下拉刷新能正常工作,http://www.cocoachina.com/bbs/simple/?t154091.html
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
	if (_refreshHeaderView == nil) {
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		_refreshHeaderView.delegate = self;
		[self.tableView addSubview:_refreshHeaderView];
        
	}
    
    if (_loadingMoreView == nil) {
		_loadingMoreView = [[EnLoadingMoreView alloc] initWithFrame:CGRectZero];
        _loadingMoreView.loadingMoreDelegate = self;
        [self.tableView addSubview:_loadingMoreView];
		
	}
    
    //加载数据
    _isHasMore = YES;
    _reloading = YES;
    [_refreshHeaderView setLoadingStateWithScrollView:self.tableView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //加载数据
    _isHasMore = YES;
    _reloading = YES;
    [_refreshHeaderView setLoadingStateWithScrollView:self.tableView];
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
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [_loadingMoreView enLoadingMoreScrollViewDataSourceDidFinishedLoading:self.tableView]; // 这个状态会更改loading moreview 的位置
    _reloading = NO;
}
- (void)doneLoadingMoreData {
    [_loadingMoreView enLoadingMoreScrollViewDataSourceDidFinishedLoading:self.tableView];
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
