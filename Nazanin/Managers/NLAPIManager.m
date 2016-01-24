//
//  NLAPIManager.m
//  Nazanin
//
//  Created by Abdul Qavi on 24/01/2016.
//  Copyright © 2016 NikaLabs. All rights reserved.
//

#import "NLAPIManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface NLAPIManager()

- (id)initSingleton;

@end

@implementation NLAPIManager

#pragma mark - NLAPIManager Signleton

- (id)initSingleton {
    
    if ((self = [super initWithBaseURL:[NSURL URLWithString:@"http://nikalabs.com/api/"]])) {
        
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    
    return self;
}

+ (NLAPIManager *)sharedManager {
    
    static NLAPIManager *_default = nil;
    if (_default != nil) {
        return _default;
    }
    
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void) {
        
        _default = [[NLAPIManager alloc] initSingleton];
    });
    
    return _default;
}

#pragma  mark - Utility methods

- (void)showServiceFailureError:(NSError *)error {
    
    if (error.code == NSURLErrorTimedOut) {
        [SVProgressHUD showErrorWithStatus:@"REQ_TIMEOUT"];
    }
    else if (error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost) {
        [SVProgressHUD showErrorWithStatus:@"NO_INTERNET"];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"SERVER_ERROR"];  // :error.description
    }
}

#pragma mark - Service calls

/************************ POST Methods ************************/

- (void)loginWith:(NSDictionary*)params andTarget:(id)target {
    
    id <NLAPIManagerDelegate> delegate = target;
    
    [SVProgressHUD showWithStatus:@"AUTHENTICATING" maskType:SVProgressHUDMaskTypeClear];
    
    [self POST:[NSString stringWithFormat:@"%@", @"login"] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        if ( [delegate respondsToSelector:@selector(loginCallback:)]) {
            [delegate loginCallback:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse* )task.response;
        if (httpResponse.statusCode == 403) { }
        else {
            [self showServiceFailureError:error];
        }

        
    }];
}


@end
