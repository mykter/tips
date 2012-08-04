//
//  UITableViewControllerWithLoadingViewController.h
//  wherearemystaff
//
//  Created by Tomas McGuinness on 21/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UITableViewControllerWithLoadingViewController : UITableViewController

@property (nonatomic, retain) UIView *innerLoadingView;
@property (nonatomic, retain) UIActivityIndicatorView *innerIndicatorView;

@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UIActivityIndicatorView *indicatorView;

- (void)showLoading:(NSString *)message;
- (void)hideLoading;

@end
