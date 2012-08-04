//
//  RKQRCodeController.h
//  RoundKeeper
//
//  Created by Michael Wawra on 04/03/2012.
//  Copyright (c) 2012 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "QRCodeReader.h"

@interface RKQRCodeController : UIViewController <ZXingDelegate, UIActionSheetDelegate>
{
    IBOutlet UITextView *resultsView;
    NSString *resultsToDisplay;   
}

@property (nonatomic, retain) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic, retain) ZXingWidgetController *widController;
@property (nonatomic, retain) QRCodeReader* qrcodeReader;

-(IBAction)scanButtonPress:(id)sender;

@end
