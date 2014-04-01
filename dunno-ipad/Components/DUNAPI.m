#import "DUNAPI.h"
#import "DUNSession.h"

#import <AFNetworking/AFNetworking.h>

@implementation DUNAPI

+ (instancetype) sharedInstance
{
  static dispatch_once_t p = 0;
  __strong static DUNAPI *sharedObject = nil;
  dispatch_once(&p, ^{
    sharedObject = [[self alloc] init];
  });
  return sharedObject;
}

- (void) loginTeacherWithUsername:(NSString*)username andPassword:(NSString*)password success:(void(^)(DUNTeacher *teacher))successBlock error:(void(^)(NSError *error))errorBlock
{
  NSParameterAssert(username!=nil);
  NSParameterAssert(password!=nil);
  
  NSDictionary *params = @{@"teacher[email]":username, @"teacher[password]":password};
  
  NSString *endpoint = [NSString stringWithFormat:@"%@/teachers/sign_in",@"http://localhost:3000/api/v1"];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
  
  [manager POST:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

    NSLog(@"ok --- %@", responseObject);
    
    successBlock(nil);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    errorBlock(error);
  }];
}


#pragma mark - 
#pragma mark - Private Methods


@end
