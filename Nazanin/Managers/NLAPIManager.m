//
//  NLAPIManager.m
//  Nazanin
//
//  Created by Abdul Qavi on 24/01/2016.
//  Copyright © 2016 NikaLabs. All rights reserved.
//

#import "NLAPIManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NLCinema.h"

@interface NLAPIManager()

- (id)initSingleton;

@end

@implementation NLAPIManager

#pragma mark - NLAPIManager Signleton

- (id)initSingleton {
    
    if ((self = [super initWithBaseURL:[NSURL URLWithString:@"http://localhost/movie_ticket_reserv_rest"]])) {
        
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
        [SVProgressHUD showErrorWithStatus:@"SERVER_ERROR"];
    }
}

#pragma mark - Service calls

- (void)getAllValues:(NSString*)value andTarget:(id)target {
    
    id <NLAPIManagerDelegate> delegate = target;
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeClear];
    
    [self GET:[NSString stringWithFormat:@"all_home_values.php?all_home_values=%@", value] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // We Parse Server data into our objects, and then redirect data to the delegate
        [SVProgressHUD dismiss];
        NSLog(@"JSON: %@", responseObject);
        
        
        NSDictionary* dict = (NSDictionary *)responseObject;

        if ([dict[@"status"] intValue] == 1) {
            
            NSArray* cinemaSource = dict[@"cinemas"];

            NSMutableArray* cinemaDestinations = [NSMutableArray array];
            
            for (NSDictionary* cinema in cinemaSource) {
                
                NLCinema* cin = [[NLCinema alloc] init];
                cin.cinemaID = cinema[@"cinema_id"];
                cin.cinemaName = cinema[@"cinema_name"];
                
                [cinemaDestinations addObject:cin];
            }

            if ([delegate respondsToSelector:@selector(getAllValuesCallback:)]) {
                [delegate getAllValuesCallback:cinemaDestinations];
            }
        }
        else {   }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        [self showServiceFailureError:error];
    }];
}


-(void)getPhotos:(NSDictionary *)params andTarget:(id)target {
    
//    nikalabs.com/api/getPhotos?id=abc&number_of_photos=50

    id <NLAPIManagerDelegate> delegate = target;
    
    [self GET:[NSString stringWithFormat:@"seats.php?available_seats=1"] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // We Parse Server data into our objects, and then redirect data to the delegate

        if ([delegate respondsToSelector:@selector(getPhotosCallback:)]) {
            [delegate getPhotosCallback:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showServiceFailureError:error];
    }];
    
}


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
