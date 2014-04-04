#import "DUNOpenEvent.h"
#import "DUNAPI.h"
#import "DUNSession.h"

@interface DUNOpenEvent()
@property (nonatomic, strong) DUNEvent *event;
@end

@implementation DUNOpenEvent

- (instancetype) initWithEvent:(DUNEvent*)event
{
  NSParameterAssert(event!=nil);
  
  if ((self = [self init])){
    _event = event;
  }
  
  return self;
}

- (void) executeOnSuccess:(void(^)(DUNEvent *eventOpened))successBlock error:(void(^)(NSError *error))errorBlock
{
  NSParameterAssert(_event!=nil);
  
  [[DUNAPI sharedInstance] openEvent:_event success:^(DUNEvent *eventOpened) {

    DUNSession *session = [DUNSession sharedInstance];
    session.activeEvent = eventOpened;
    
    //sign all pusher operations.
    
    //invalidate
    _event = nil;
    
    successBlock(eventOpened);
    
  } error:^(NSError *error) {
    errorBlock(error);
  }];
  
}

@end
