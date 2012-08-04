//
//  LoginViewController.m
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize emailAddressField;
@synthesize passwordField;

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
    
    self.navigationItem.title = @"Login";
    
    self.emailAddressField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 170, 40)];
    self.emailAddressField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailAddressField.placeholder = @"email address";
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 170, 40)];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.placeholder = @"password";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)done
{
    //HomeViewController *homeCon = [[HomeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    //[self.navigationController pushViewController:homeCon animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.row == 0)
    {
        [cell.contentView addSubview:self.emailAddressField];
        cell.textLabel.text = @"Email";
    }
    else
    {
        [cell.contentView addSubview:self.passwordField];
        cell.textLabel.text = @"Password";        
    }
    
    return cell;
}

@end
