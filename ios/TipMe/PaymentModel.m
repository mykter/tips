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
    NSString *urlString = [NSString stringWithFormat:@"http://%@/pay/%@/%@/%@",
                           SERVER,
                           customerId,
                           @"2c45d4d6-7427-45ca-88ed-3d7f275646b6",
                           amount];
    
    NSLog(@"Sending the request to %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
    [requestObj setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:requestObj queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Request failed: %@", [error localizedDescription]);
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate sendPaymentFailed];
             });
         }
         else
         {
             if(httpResp.statusCode == 200)
             {
                 NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                 
                 if(error != nil)
                 {
                     NSLog(@"Eror parsing login response: %@", [error localizedDescription]);
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [self.delegate sendPaymentFailed];
                     });
                     
                     return;
                 }
                 
                 NSString *paymentUrl = [results valueForKey:@"paymentURL"];
                 
                 NSLog(@"URL Returned: %@", paymentUrl);
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate sendPaymentOpenLink:paymentUrl];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate sendPaymentFailed];
                 });
             }
         }
     }];
}

- (void)paymentAuthorized
{
    [self.delegate sendPaymentComplete];
}

- (void)paymentCancelled
{
    [self.delegate sendPaymentFailed];
}

@end
