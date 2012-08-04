//
//  PaymentViewController.m
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import "PaymentViewController.h"

@implementation PaymentViewController

@synthesize waiterIdField;
@synthesize customerIdField;
@synthesize amountField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self)
    {
        self.model = [[PaymentModel alloc] init];
        self.model.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Send a Payment";
    
    self.waiterIdField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 170, 40)];
    self.waiterIdField.keyboardType = UIKeyboardTypeNumberPad;
    self.waiterIdField.placeholder = @"The waiter's id";
    
    self.customerIdField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 170, 40)];
    self.customerIdField.keyboardType = UIKeyboardTypeNumberPad;
    self.customerIdField.placeholder = @"Your id";
    
    self.amountField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 170, 40)];
    self.amountField.keyboardType = UIKeyboardTypeDecimalPad;
    self.amountField.placeholder = @"The amount to tip";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendPayment)];
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

- (void)sendPayment
{
    //if([self.model validate:self.waiterIdField.text customerId:self.customerIdField.text amount:self.amountField.text])
    //{
    [self showLoading:@"Authorizing..."];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    [self.model sendPayment:self.waiterIdField.text customerId:self.customerIdField.text amount:self.amountField.text];
    //}
}

#pragma mark - PaymentModelDelegate

- (void)sendPaymentOpenLink:(NSString *)paymentUrl
{
    [self hideLoading];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    
    AuthorizationViewController *authorizeView = [[AuthorizationViewController alloc] init];
    [authorizeView openUrl:paymentUrl];
    authorizeView.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:authorizeView];
    [self presentModalViewController:navController animated:YES];
}

#pragma mark - AuthorizationViewController delegate

- (void)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Enter payment details";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
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
    
    switch(indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Waiter Id";
            [cell.contentView addSubview:self.waiterIdField];
            break;
        case 1:
            cell.textLabel.text = @"Customer Id";
            [cell.contentView addSubview:self.customerIdField];
            break;
        case 2:
            cell.textLabel.text = @"Amount";
            [cell.contentView addSubview:self.amountField];
            break;
    }
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
