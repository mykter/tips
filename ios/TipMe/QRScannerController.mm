//
//  RKQRCodeController.m
//  RoundKeeper
//
//  Created by Michael Wawra on 04/03/2012.
//  Copyright (c) 2012 Wawra Corp. All rights reserved.
//

#import "QRScannerController.h"
#import "QRCodeReader.h"

@implementation QRScannerController

@synthesize qrcodeReader;
@synthesize widController;
@synthesize navigationItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{

    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma ZXing Protocol
-(IBAction)scanButtonPress:(id)sender
{
    [resultsView setText:resultsToDisplay];
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
    
    if (self.isViewLoaded)
    {
        [resultsView setText:resultsToDisplay];
        [resultsView setNeedsDisplay];
    }
    
    //This is displayed over the camera image, and is useful for flashing an indicator etc.
    OverlayView *ov = controller.overlayView;


}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller 
{

    [self dismissModalViewControllerAnimated:NO];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

    
@end
