//
//  WebViewController.h
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthorizationViewControllerDelegate <NSObject>

- (void)paymentComplete;
- (void)paymentCancelled;
- (void)cancel;

@end

@interface AuthorizationViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) id<AuthorizationViewControllerDelegate> delegate;
@property (strong, nonatomic) UIWebView *webView;

- (void)openUrl:(NSString *)url;

@end
