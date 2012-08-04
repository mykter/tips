//
//  WebViewController.m
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import "AuthorizationViewController.h"

@implementation AuthorizationViewController

@synthesize delegate;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Authorize Payment";
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	
    self.webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, 320, 480)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor purpleColor];
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)openUrl:(NSString *)urlAddress
{
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void)cancel
{
    [self.delegate cancel];
}

- (BOOL)webView:(UIWebView *)webViewB shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // Intercept the callback from the payment and redirect if necessary.
    //
    NSLog(@"Loading: %@", request.URL.absoluteString);
    
    if([request.URL.host isEqualToString:@"10.0.1.86"])
    {
        [self.delegate paymentComplete];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Finished Load");
}

- (void)webViewDidStartLoad:(UIWebView *)webViewB
{
    // Intercept the callback from the payment and redirect if necessary.
    //
    NSLog(@"Loading: %@", webViewB.request.URL.absoluteString);
    
    if(webViewB.request.URL.absoluteString == @"http://www.bing.com")
    {
        [self.delegate paymentComplete];
    }    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed to load page: %@", [error localizedDescription]);
}

@end
