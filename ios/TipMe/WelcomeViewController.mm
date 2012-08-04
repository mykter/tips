//
//  WelcomeViewController.m
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    
    self.navigationItem.title = @"Lannyapp";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180.0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *welcomeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//    welcomeView.backgroundColor = [UIColor purpleColor];
//    return welcomeView;
//}

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
        UIButton *signinButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [signinButton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
        [signinButton setTitleColor:[UIColor blueColor] forState:UIControlEventAllEvents];
        [signinButton setTitle:@"Sign In" forState:UIControlStateNormal];
        signinButton.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:signinButton];
    }
    else
    {
        UIButton *signinButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [signinButton setTitleColor:[UIColor blueColor] forState:UIControlEventAllEvents];
        [signinButton setTitle:@"Log In" forState:UIControlStateNormal];
        [signinButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        signinButton.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:signinButton];
    }
    
    return cell;
}

- (void)signin
{
    SignInViewController *viewCon = [[SignInViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:viewCon animated:YES];
}

- (void)login
{
    LoginViewController *viewCon = [[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:viewCon animated:YES];
}

@end
