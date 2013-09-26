//
//  SURLConnection.m
//
//  Created by Satheeshwaran on 8/19/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import "SURLConnection.h"

@interface SURLConnection ()

@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,assign) BOOL finishedLoading;

@end


@implementation SURLConnection



- (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSHTTPURLResponse *)response error:(NSError *)error
{
    _finishedLoading=NO;
    _receivedData=[NSMutableData new];
    _error=error;
    _response=response;
    
    NSURLConnection*con=[NSURLConnection connectionWithRequest:request delegate:self];
    
    [con start];
    CFRunLoopRun();
    
    return _receivedData;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _response=(NSHTTPURLResponse *)response;
    _receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_receivedData appendData:data];
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
      CFRunLoopStop(CFRunLoopGetCurrent());
   
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    _error=error;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] > 0) {
        
        CFRunLoopStop(CFRunLoopGetCurrent());

        [Utils showMessage:@"Error" withTitle:@"User Login failed more than once, please try later to prevent account lock issues"];
        
    }
    else
    {
        
        NSURLCredential *credential = [NSURLCredential credentialWithUser:@"SomeUserName"
                                                                 password:@"SomePassword"
                                                              persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }
}


@end
