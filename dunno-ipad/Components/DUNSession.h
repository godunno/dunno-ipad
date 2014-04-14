#import "DUNTeacher.h"
#import "DUNEvent.h"
#import "DUNMedia.h"
#import "DUNPoll.h"

extern NSString * const DUNTimelineChangesNotificationName;

@interface DUNSession : NSObject

@property (nonatomic, strong) DUNTeacher *currentTeacher;

@property (nonatomic, strong) DUNEvent *activeEvent;

+ (instancetype) sharedInstance;

- (void) subscribeTimelineChangesObserver:(id)observer execute:(void(^)(DUNTimeline *timeline))executeBlock;

- (void) fireTimelineChangeNotification;

- (void) closeCurrentEvent;

- (void) releasePollAtCurrentEvent:(DUNPoll *)poll;
- (void) releaseMediaAtCurrentEvent:(DUNMedia *)media;

@end
