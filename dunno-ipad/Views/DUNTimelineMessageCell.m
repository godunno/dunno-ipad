#import "DUNTimelineMessageCell.h"

@interface DUNTimelineMessageCell()
@property (nonatomic, weak) IBOutlet UIImageView *autorProfileImageView;
@property (nonatomic, weak) IBOutlet UILabel *autorLabel;
@property (nonatomic, weak) IBOutlet UILabel *sentAtLabel;
@property (nonatomic, weak) IBOutlet UITextView *messageTextView;
@end

@implementation DUNTimelineMessageCell

- (void)layoutSubviews
{
  [super layoutSubviews];
  // customize
}

@end
