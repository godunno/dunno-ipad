#import "DUNTeacher.h"

@interface DUNSession : NSObject

@property (nonatomic, strong) DUNTeacher *currentTeacher;

+ (instancetype) sharedInstance;

@end
