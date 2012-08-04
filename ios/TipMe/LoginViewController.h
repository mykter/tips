//
//  LoginViewController.h
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface LoginViewController : UITableViewController

@property (strong, nonatomic) UITextField *emailAddressField;
@property (strong, nonatomic) UITextField *passwordField;

@end
