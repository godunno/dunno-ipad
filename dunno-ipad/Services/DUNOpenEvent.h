#import "DUNEvent.h"

@interface DUNOpenEvent : NSObject



- (instancetype) initWithEvent:(DUNEvent*)event;

- (void) execute;

@end
