#import "DUNTeacher.h"
#import "DUNEvent.h"
#import "DUNPoll.h"
#import "DUNMedia.h"

@interface DUNAPI : NSObject

+ (instancetype) sharedInstance;

- (void) loginTeacherWithUsername:(NSString*)teacher andPassword:(NSString*)password success:(void(^)(DUNTeacher *teacher))successBlock error:(void(^)(NSError *error))errorBlock;

- (void) openEvent:(DUNEvent*)event success:(void(^)(DUNEvent *eventOpened))successBlock error:(void(^)(NSError *error))errorBlock;

- (void) closeEvent:(DUNEvent*)event success:(void(^)(DUNEvent *eventClosed))successBlock error:(void(^)(NSError *error))errorBlock;

- (void) releasePoll:(DUNPoll*)poll success:(void(^)(void))successBlock error:(void(^)(NSError *error))errorBlock;

- (void) releaseMedia:(DUNMedia*)media success:(void(^)(void))successBlock error:(void(^)(NSError *error))errorBlock;

@end
