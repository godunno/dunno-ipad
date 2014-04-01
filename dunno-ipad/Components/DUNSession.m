#import "DUNSession.h"

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

@end
