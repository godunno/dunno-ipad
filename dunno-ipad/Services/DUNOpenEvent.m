#import "DUNOpenEvent.h"

#import "DUNAPI.h"
#import "DUNPusher.h"
#import "DUNSession.h"

#import "DUNTimelineUserMessage.h"

@interface DUNOpenEvent()
@property (nonatomic, strong) DUNEvent *event;
@property (nonatomic, strong) DUNSession *session;
@end

@implementation DUNOpenEvent

- (instancetype) initWithEvent:(DUNEvent*)event
{
  NSParameterAssert(event!=nil);
  
  if ((self = [self init])){
    _event = event;
    _session = [DUNSession sharedInstance];
  }
  
  return self;
}

- (void) executeOnSuccess:(void(^)(DUNEvent *eventOpened))successBlock error:(void(^)(NSError *error))errorBlock
{
  NSParameterAssert(_event!=nil);
  
  [[DUNAPI sharedInstance] openEvent:_event success:^(DUNEvent *eventOpened) {
    
    _session.activeEvent = eventOpened;
    
    [self registerPusherEvents];
    
    _event = nil;
    
    successBlock(eventOpened);
    
  } error:^(NSError *error) {
    errorBlock(error);
  }];
  
}

# pragma mark -
# pragma mark - Pusher events

- (void) registerPusherEvents
{
  
  NSParameterAssert(_event!=nil);
  
#if DEBUG
  NSParameterAssert(_event.studentMessageEvent!=nil);
  NSParameterAssert(_event.upDownVoteMessageEvent!=nil);
#else
  //TODO show error on modal dialog?
#endif
  
  DUNPusher *pusher = [DUNPusher sharedInstance].connect;
  
  [pusher subscribeToChannelNamed:_event.channelName withEventNamed:_event.studentMessageEvent handleWithBlock:^(NSDictionary *jsonDictionary) {
    
    NSError *error = nil;
    DUNTimelineUserMessage *newMessage = [MTLJSONAdapter modelOfClass:DUNTimelineUserMessage.class fromJSONDictionary:jsonDictionary error:&error];
    
#if DEBUG
    NSAssert(error==nil, @"Error parsing JSON to DUNTimelineUserMessage on send Message to Timeline Pusher response");
#else
    //TODO show error on modal dialog?
#endif
    
    [_session.activeEvent.timeline.messages addObject:newMessage];
    [_session fireTimelineChangeNotification];
  }];
  
  [pusher subscribeToChannelNamed:_event.channelName withEventNamed:_event.upDownVoteMessageEvent handleWithBlock:^(NSDictionary *jsonDictionary) {
    
    NSError *error = nil;
    DUNTimelineUserMessage *messageVoted = [MTLJSONAdapter modelOfClass:DUNTimelineUserMessage.class fromJSONDictionary:jsonDictionary error:&error];
    
#if DEBUG
    NSAssert(error==nil, @"Error parsing JSON to DUNTimelineUserMessage on up/down vote Pusher response");
#else
    //TODO show error on modal dialog?
#endif
    
    [_session.activeEvent.timeline updateMessage:messageVoted];
    [_session fireTimelineChangeNotification];    
  }];
  
}


@end
