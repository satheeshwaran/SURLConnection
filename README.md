SURLConnection
==============

A synchronous NSURLConnection subclass with basic authentication challenge

It is very easy to use.


    SURLConnection  *conn = [[SURLConnection alloc] init];
    
    NSData *responseData  = [conn sendSynchronousRequest:request returningResponse:nil error:nil];
