//
//  HomeViewController.h
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "QRCodeReader.h"

@interface HomeViewController : UITableViewController <ZXingDelegate>

@property (strong, nonatomic) UIButton *payButton;

@property (nonatomic, retain) ZXingWidgetController *widController;
@property (nonatomic, retain) QRCodeReader* qrcodeReader;



@end
