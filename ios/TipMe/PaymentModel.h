//
//  PaymentModel.h
//  TipMe
//
//  Created by Tomas McGuinness on 04/08/2012.
//  Copyright (c) 2012 API HackDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@protocol PaymentModelDelegate <NSObject>

- (void)sendPaymentOpenLink:(NSString *)paymentUrl;
- (void)sendPaymentComplete;
- (void)sendPaymentFailed;

@end

@interface PaymentModel : NSObject

@property (strong, nonatomic) id<PaymentModelDelegate> delegate;

- (BOOL)validate:(NSString *)waiterId customerId:(NSString *)customerId amount:(NSString *)amount;
- (void)sendPayment:(NSString *)waiterId customerId:(NSString *)customerId amount:(NSString *)amount;
- (void)paymentAuthorized;
- (void)paymentCancelled;

@end
