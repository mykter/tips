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
#import "PaymentViewController.h"

@interface HomeViewController : UIViewController <ZXingDelegate>

@property (strong, nonatomic) UIButton *payButton;
@property (nonatomic) BOOL successfullyCaptured;
@property (nonatomic, retain) ZXingWidgetController *widController;
@property (nonatomic, retain) QRCodeReader* qrcodeReader;



@end
