//
//  PaymentViewController.m
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import "PaymentViewController.h"

@implementation PaymentViewController

@synthesize amountField;
@synthesize waiterId;

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
    
    self.amountField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 170, 40)];
    self.amountField.keyboardType = UIKeyboardTypeDecimalPad;
    self.amountField.placeholder = @"The amount to tip";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tip" style:UIBarButtonItemStyleDone target:self action:@selector(sendPayment)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPayment)];

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
    [self.amountField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)sendPayment
{
    [self showLoading:@"Authorizing..."];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    self.model.delegate = self;
    [self.model sendPayment:self.waiterId customerId:@"2" amount:self.amountField.text];
}

- (void)cancelPayment
{
    self.model.delegate = nil;
    [self hideLoading];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - PaymentModelDelegate

- (void)sendPaymentOpenLink:(NSString *)paymentUrl
{
    [self hideLoading];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    
    AuthorizationViewController *authorizeView = [[AuthorizationViewController alloc] init];
    authorizeView.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:authorizeView];
    [self presentModalViewController:navController animated:YES];
    
    [authorizeView openUrl:paymentUrl];
}

- (void)sendPaymentComplete
{
    [self dismissModalViewControllerAnimated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment Sent"
                                                    message:@"Your tip has been sent and will be received in a few days."
                                                   delegate:self
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)sendPaymentFailed
{
    [self hideLoading];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    
    [self dismissModalViewControllerAnimated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Send Payment"
                                                    message:@"A horrible error has occured and we have to stop."
                                                   delegate:self
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles: nil];
    [alert show];
}

#pragma mark - AuthorizationViewController delegate

- (void)paymentComplete
{
    self.amountField.text = @"";
    [self.model paymentAuthorized];
}

- (void)paymentCancelled
{
    [self.model paymentCancelled];
}

- (void)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Enter the tip amount";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
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
    
    cell.textLabel.text = @"Amount";
    [cell.contentView addSubview:self.amountField];
    
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
