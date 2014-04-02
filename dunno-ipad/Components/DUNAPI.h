#import "DUNTeacher.h"
#import "DUNEvent.h"

@interface DUNAPI : NSObject

+ (instancetype) sharedInstance;

- (void) loginTeacherWithUsername:(NSString*)teacher andPassword:(NSString*)password success:(void(^)(DUNTeacher *teacher))successBlock error:(void(^)(NSError *error))errorBlock;

- (void) openEvent:(DUNEvent*)event success:(void(^)(DUNEvent *eventOpened))successBlock error:(void(^)(NSError *error))errorBlock;

@end
