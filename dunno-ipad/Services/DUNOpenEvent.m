#import "DUNOpenEvent.h"

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

- (void) execute
{
  NSParameterAssert(_event!=nil);
  
  DUNSession *session = [DUNSession sharedInstance];
  session.activeEvent = _event;
  
  //sign all pusher operations.

  //invalidate
  _event = nil;
}

@end
