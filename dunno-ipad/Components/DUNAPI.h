#import "DUNTeacher.h"

@interface DUNAPI : NSObject

+ (instancetype) sharedInstance;

- (void) loginTeacherWithUsername:(NSString*)teacher andPassword:(NSString*)password success:(void(^)(DUNTeacher *teacher))successBlock error:(void(^)(NSError *error))errorBlock;

@end
