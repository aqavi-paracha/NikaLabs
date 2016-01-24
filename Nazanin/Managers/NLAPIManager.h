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

@end

@interface NLAPIManager : AFHTTPSessionManager

+ (NLAPIManager* )sharedManager;

- (void)loginWith:(NSDictionary*)params andTarget:(id)target;

@end
