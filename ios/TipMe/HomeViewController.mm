//
//  HomeViewController.m
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import "HomeViewController.h"
#import "ZXingWidgetController.h"
#import "QRCodeReader.h"

@implementation HomeViewController

@synthesize payButton;
@synthesize qrcodeReader;
@synthesize widController;
@synthesize successfullyCaptured;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Welcome";
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    [self.view addSubview:imageView];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.successfullyCaptured)
    {
        PaymentViewController *payCon = [[PaymentViewController alloc] init];
        [self.navigationController pushViewController:payCon animated:YES];
    }
    else
    {
        [self launchQRScanner];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)takePayment
{
    UIViewController *controller = [[UIViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];

    [self launchQRScanner];
}

#pragma ZXing Protocol
-(void)launchQRScanner
{
   
    widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    qrcodeReader = [[QRCodeReader alloc] init];
    
    NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
    widController.readers = readers;
    [self presentViewController:widController animated:NO completion: nil];
    NSLog(@"[RKQRViewController] Scan button was pressed.");
}

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result
{
    NSLog(@"Scanned data: %@",result);
    
    self.successfullyCaptured = YES;
    
    //This is displayed over the camera image, and is useful for flashing an indicator etc.
    OverlayView *ov = controller.overlayView;
    
    [controller stopCapture];
    [self dismissModalViewControllerAnimated:NO];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    
    [self dismissModalViewControllerAnimated:NO];
}



@end
