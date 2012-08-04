//
//  PaymentModel.m
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import "PaymentModel.h"

@implementation PaymentModel

@synthesize delegate;

- (BOOL)validate:(NSString *)waiterId customerId:(NSString *)customerId amount:(NSString *)amount
{
    return TRUE;
}

- (void)sendPayment:(NSString *)waiterId customerId:(NSString *)customerId amount:(NSString *)amount
{
    [self.delegate sendPaymentOpenLink:@"http://www.gocardless.com"];
}

- (void)paymentAuthorized
{
    
}

- (void)paymentCancelled
{
    
}

@end
