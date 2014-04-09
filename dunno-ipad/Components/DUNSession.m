#import "DUNSession.h"

NSString * const DUNTimelineChangesNotificationName =  @"vc.dunno.notification.timeline.changes";

@implementation DUNSession

+ (instancetype) sharedInstance
{
  static dispatch_once_t p = 0;
  __strong static DUNSession *sharedObject = nil;
  dispatch_once(&p, ^{
    sharedObject = [[self alloc] init];
  });
  return sharedObject;
}

- (void) subscribeTimelineChangesObserver:(id)observer execute:(void(^)(DUNTimeline *timeline))executeBlock
{
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center addObserverForName:DUNTimelineChangesNotificationName
                      object:nil
                       queue:nil
                  usingBlock:^(NSNotification *notification) {
                    executeBlock(self.activeEvent.timeline);
                  }];
}

- (void) fireTimelineChangeNotification
{
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center postNotificationName:DUNTimelineChangesNotificationName object:self.activeEvent];
}


- (void) closeCurrentEvent
{
  _activeEvent.status = DUNEventClosed;
  [_currentTeacher updateEvent:[_activeEvent copy]];
  _activeEvent = nil;
}

- (void) releasePollAtCurrentEvent:(DUNPoll *)poll;
{
  poll.status = DUNPollReleased;
  
  [_activeEvent.polls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    DUNPoll *p =obj;
    if([p.uuid isEqualToString:poll.uuid])
    {
      [_activeEvent.polls replaceObjectAtIndex:idx withObject:poll];
      return;
    }
  }];
  
  //assert false?
}


@end
