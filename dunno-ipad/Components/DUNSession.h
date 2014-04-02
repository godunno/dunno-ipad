#import "DUNTeacher.h"
#import "DUNEvent.h"

@interface DUNSession : NSObject

@property (nonatomic, strong) DUNTeacher *currentTeacher;

@property (nonatomic, strong) DUNEvent *activeEvent;

+ (instancetype) sharedInstance;

@end
