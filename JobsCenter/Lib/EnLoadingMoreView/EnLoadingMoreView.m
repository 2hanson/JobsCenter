//
//  EnLoadingMoreView.m
//  imeeta
//
//  Created by Jason Li on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnLoadingMoreView.h"

#define BOTTOM_INSET_HEIGHT 40.f

@implementation EnLoadingMoreView

@synthesize loadingMoreDelegate = _loadingMoreDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor= [UIColor clearColor];
        self.clipsToBounds = YES;
        
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
		//view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
        
        UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.frame = CGRectMake(150, 10, 20, 20);
        [indicatorView startAnimating];
        [self addSubview:indicatorView];
        _activityIndicatorView = indicatorView;
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 20)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = UITextAlignmentCenter;
        _textLabel.textColor = [UIColor lightGrayColor];
        _textLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_textLabel];
        
        [self setState:EnLoadingMoreViewNormalState];
    }
    return self;
}

- (void)setState:(EnLoadingMoreViewState)aState
{
    switch (aState) {
        case EnLoadingMoreViewNormalState:{
            [_activityIndicatorView stopAnimating];
            _textLabel.hidden = NO;
            _textLabel.text = @"Pull up to load more...";
            self.userInteractionEnabled = YES;
            break;
        }
        case EnLoadingMoreViewLoadingState:{
            [_activityIndicatorView startAnimating];
            _textLabel.hidden = YES;
            _textLabel.text = nil;
            self.userInteractionEnabled = NO;
            break;
        }
        case EnLoadingMoreViewNoreMoreState:{
            [_activityIndicatorView stopAnimating];
            _textLabel.hidden = NO;
            _textLabel.text = @"No more data...";
            self.userInteractionEnabled = NO;
            break;
        }
        default:
            break;
    }
    _state = aState;
}

- (void)enLoadingMoreScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    BOOL reloading = YES;
    BOOL isHasMore =  NO;
    
    if ([_loadingMoreDelegate respondsToSelector:@selector(enLoadingMoreViewDataSourceIsLoading:)]) {
        reloading = [_loadingMoreDelegate enLoadingMoreViewDataSourceIsLoading:self];
    }
    
    if ([_loadingMoreDelegate respondsToSelector:@selector(enLoadingMoreViewDataSourceHasMore:)]) {
        isHasMore = [_loadingMoreDelegate enLoadingMoreViewDataSourceHasMore:self];
    }
    
    if ((scrollView.contentOffset.y + scrollView.bounds.size.height - BOTTOM_INSET_HEIGHT > scrollView.contentSize.height) && (reloading == NO) && (isHasMore == YES)) {
        [self setState:EnLoadingMoreViewLoadingState];
        
        if ([_loadingMoreDelegate respondsToSelector:@selector(enLoadingMoreViewTriggerRefresh:)]) {
            [_loadingMoreDelegate enLoadingMoreViewTriggerRefresh:self];
        }
    }
}

- (void)enLoadingMoreScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView
{
    BOOL isHasMore = NO;
    if ([_loadingMoreDelegate respondsToSelector:@selector(enLoadingMoreViewDataSourceHasMore:)]) {
        isHasMore = [_loadingMoreDelegate enLoadingMoreViewDataSourceHasMore:self];
    }
    if (isHasMore) {
        [self setState:EnLoadingMoreViewNormalState];
    } else {
        [self setState:EnLoadingMoreViewNoreMoreState];
    }
    
    self.frame = CGRectMake(0, scrollView.contentSize.height, 320, BOTTOM_INSET_HEIGHT);
	UIEdgeInsets insets =  scrollView.contentInset;
    insets.bottom = BOTTOM_INSET_HEIGHT;
    scrollView.contentInset = insets;
}

- (void)clickAction:(id)sender
{
    BOOL reloading = YES;
    if ([_loadingMoreDelegate respondsToSelector:@selector(enLoadingMoreViewDataSourceIsLoading:)]) {
        reloading = [_loadingMoreDelegate enLoadingMoreViewDataSourceIsLoading:self];
    }
    if (reloading) {
        return;
    }
    [self setState:EnLoadingMoreViewLoadingState];
    if ([_loadingMoreDelegate respondsToSelector:@selector(enLoadingMoreViewTriggerRefresh:)]) {
        [_loadingMoreDelegate enLoadingMoreViewTriggerRefresh:self];
    }
}

+ (CGFloat)enLoadingMoreViewBottomContentInset
{
    return BOTTOM_INSET_HEIGHT;
}

@end
