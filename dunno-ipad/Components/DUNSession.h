#import "DUNTeacher.h"
#import "DUNEvent.h"

extern NSString * const DUNTimelineChangesNotificationName;

@interface DUNSession : NSObject

@property (nonatomic, strong) DUNTeacher *currentTeacher;

@property (nonatomic, strong) DUNEvent *activeEvent;

+ (instancetype) sharedInstance;

- (void) subscribeTimelineChangesObserver:(id)observer execute:(void(^)(DUNTimeline *timeline))executeBlock;

- (void) fireTimelineChangeNotification;

@end
