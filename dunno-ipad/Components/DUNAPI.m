#import "DUNAPI.h"
#import "DUNSession.h"

#import <AFNetworking/AFNetworking.h>

static const NSString *BASE_URL = @"http://localhost:3000/api/v1";

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
  
  NSString *endpoint = [NSString stringWithFormat:@"%@/teachers/sign_in", BASE_URL];
  
  NSDictionary *params = @{@"teacher[email]":username, @"teacher[password]":password};
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
  
  [manager POST:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSError *error = nil;
    DUNTeacher *teacher = [MTLJSONAdapter modelOfClass:DUNTeacher.class fromJSONDictionary:responseObject error:&error];
    
    if(!error)
      successBlock(teacher);
    else
      errorBlock(error);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    errorBlock(error);
  }];
}

- (void) openEvent:(DUNEvent*)event success:(void(^)(DUNEvent *eventOpened))successBlock error:(void(^)(NSError *error))errorBlock
{
  NSParameterAssert(event!=nil);
  NSParameterAssert(event.uuid!=nil);
  
  NSString *endpoint = [NSString stringWithFormat:@"%@/teacher/events/%@/open",BASE_URL,event.uuid];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
  
  [manager PATCH:endpoint parameters:[self mandatoryParams] success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSError *error = nil;
    DUNEvent *eventOpened = [MTLJSONAdapter modelOfClass:DUNEvent.class fromJSONDictionary:responseObject error:&error];
    
    if(!error)
      successBlock(eventOpened);
    else
      errorBlock(error);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    errorBlock(error);
  }];
  
}

- (void) closeEvent:(DUNEvent*)event success:(void(^)(DUNEvent *eventClosed))successBlock error:(void(^)(NSError *error))errorBlock
{
  NSParameterAssert(event!=nil);
  NSParameterAssert(event.uuid!=nil);
  
  NSString *endpoint = [NSString stringWithFormat:@"%@/teacher/events/%@/close",BASE_URL,event.uuid];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
  
  [manager PATCH:endpoint parameters:[self mandatoryParams] success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSError *error = nil;
    DUNEvent *eventClosed = [MTLJSONAdapter modelOfClass:DUNEvent.class fromJSONDictionary:responseObject error:&error];
    
    if(!error)
      successBlock(eventClosed);
    else
      errorBlock(error);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    errorBlock(error);
  }];
}

- (void) releasePoll:(DUNPoll*)poll success:(void(^)(void))successBlock error:(void(^)(NSError *error))errorBlock
{
  NSParameterAssert(poll!=nil);
  NSParameterAssert(poll.uuid!=nil);
  
  NSString *endpoint = [NSString stringWithFormat:@"%@/teacher/polls/%@/release.json",BASE_URL,poll.uuid];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
  
  [manager PATCH:endpoint parameters:[self mandatoryParams] success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    successBlock();
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    errorBlock(error);
  }];
}

- (void) releaseMedia:(DUNMedia*)media success:(void(^)(void))successBlock error:(void(^)(NSError *error))errorBlock
{
  NSParameterAssert(media!=nil);
  NSParameterAssert(media.uuid!=nil);
  
  NSString *endpoint = [NSString stringWithFormat:@"%@/teacher/medias/%@/release.json",BASE_URL,media.uuid];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
  
  [manager PATCH:endpoint parameters:[self mandatoryParams] success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    successBlock();
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    errorBlock(error);
  }];
}

#pragma mark -
#pragma mark - Private Methods

- (NSMutableDictionary*)mandatoryParams
{
  NSMutableDictionary *mandatoryParams = [[NSMutableDictionary alloc] init];
  DUNSession *_session = [DUNSession sharedInstance];
  
  NSParameterAssert(_session.currentTeacher!=nil);
  NSParameterAssert(_session.currentTeacher.email!=nil);
  NSParameterAssert(_session.currentTeacher.authToken!=nil);
  
  [mandatoryParams setObject:_session.currentTeacher.email forKey:@"teacher_email"];
  [mandatoryParams setObject:_session.currentTeacher.authToken forKey:@"teacher_token"];
  
  return mandatoryParams;
}

- (NSString*)appendToURLString:(NSString*)urlString dictionaryParams:(NSDictionary*)params
{
  if(params>0)
    urlString = [urlString stringByAppendingString:@"?"];
  
  for (NSString* key in params) {
    id value = [params objectForKey:key];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,value]];
  }
  
  urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
  return urlString;
}


@end
