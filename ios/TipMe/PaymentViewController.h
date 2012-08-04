//
//  PaymentViewController.h
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentModel.h"
#import "UITableViewControllerWithLoadingViewController.h"
#import "AuthorizationViewController.h"

@interface PaymentViewController : UITableViewControllerWithLoadingViewController<PaymentModelDelegate, AuthorizationViewControllerDelegate>

@property (strong, nonatomic) PaymentModel *model;
@property (strong, nonatomic) UITextField *amountField;

@end
