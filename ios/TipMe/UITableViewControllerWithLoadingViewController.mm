//
//  UITableViewControllerWithLoadingViewController.m
//  wherearemystaff
//
//  Created by Tomas McGuinness on 21/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITableViewControllerWithLoadingViewController.h"
#import "AppDelegate.h"

@implementation UITableViewControllerWithLoadingViewController

@synthesize innerLoadingView;
@synthesize innerIndicatorView;
@synthesize loadingView;
@synthesize indicatorView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(65, 130, 190, 100)];
    self.loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    self.loadingView.tag = 102;
    [self.loadingView.layer setCornerRadius:5];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView.frame = CGRectMake(80, 20, 80, 80);
    [self.indicatorView sizeToFit];
    [self.indicatorView startAnimating];
    [self.loadingView addSubview:self.indicatorView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 190, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.tag = 101;
    
    [self.loadingView addSubview:label];
    self.loadingView.hidden = YES;
    
    [[[UIApplication sharedApplication] delegate].window addSubview:self.loadingView];
}

- (void)showLoading:(NSString *)message
{
    UILabel *loadingLabel = (UILabel *)[self.loadingView viewWithTag:101];
    loadingLabel.text = message;
    [loadingLabel setNeedsDisplay];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.loadingView.hidden = NO;
    [self.indicatorView startAnimating];
}

- (void)hideLoading
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.loadingView.hidden = YES;
    [self.indicatorView stopAnimating];
}

@end
