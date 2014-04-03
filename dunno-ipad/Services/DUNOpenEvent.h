#import "DUNEvent.h"

@interface DUNOpenEvent : NSObject

- (instancetype) initWithEvent:(DUNEvent*)event;

- (void) executeOnSuccess:(void(^)(DUNEvent *eventOpened))successBlock error:(void(^)(NSError *error))errorBlock;

@end
