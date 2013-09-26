//
//  SURLConnection.h
//
//  Created by Satheeshwaran on 8/19/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SURLConnection : NSURLConnection

@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) NSHTTPURLResponse *response;

- (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSHTTPURLResponse *)response error:(NSError *)error;

@end
