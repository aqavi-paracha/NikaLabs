//
//  NLAPIManager.h
//  Nazanin
//
//  Created by Abdul Qavi on 24/01/2016.
//  Copyright © 2016 NikaLabs. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


@protocol NLAPIManagerDelegate <NSObject>

@optional
- (void)loginCallback:(id)response;
- (void)getPhotosCallback:(id)response;
- (void)getAllValuesCallback:(id)response;

@end

@interface NLAPIManager : AFHTTPSessionManager

+ (NLAPIManager* )sharedManager;

- (void)getPhotos:(NSDictionary*)params andTarget:(id)target;
- (void)loginWith:(NSDictionary*)params andTarget:(id)target;
- (void)getAllValues:(NSString*)value andTarget:(id)target;

@end
