#import "DUNStyles.h"

@implementation DUNStyles

+ (void) roundView:(UIView*)view
{
  view.layer.cornerRadius = view.frame.size.width / 2;
  view.layer.borderWidth = 2.0f;
  view.layer.borderColor = [UIColor whiteColor].CGColor;
  view.clipsToBounds = YES;
  
}


@end
