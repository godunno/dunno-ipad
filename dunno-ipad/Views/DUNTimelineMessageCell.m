#import "DUNTimelineMessageCell.h"
#import "DUNTimelineUserMessage.h"

#import "DUNStyles.h"
#import "NSDate-Utilities.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface DUNTimelineMessageCell()

@end

@implementation DUNTimelineMessageCell

- (void) setMessage:(DUNTimelineUserMessage *)message
{
  _message = message;
  
  [_studentProfileImageView setImageWithURL:[NSURL URLWithString:_message.owner.avatarURLString]];
  _studentNameLabel.text = _message.owner.name;
  _sentAtLabel.text = [NSString stringWithFormat:@"%d:%d",[_message.sentAt hour],[_message.sentAt minute]];
  _messageTextView.text = _message.content;
  
  _upVoteLabel.text = [NSString stringWithFormat:@"%d", [_message.upVotes integerValue]];
  _downVoteLabel.text = [NSString stringWithFormat:@"%d", [_message.downVotes integerValue]];
  
  [DUNStyles roundView:_studentProfileImageView];
}

@end
