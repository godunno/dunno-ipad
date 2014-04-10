#define kDUNTimelineMessageCellRestorationId @"vc.dunno.ipad.event.dashboard.timeline.messagecell"

#import "DUNTimelineUserMessage.h"

@interface DUNTimelineMessageCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *studentProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sentAtLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@property (weak, nonatomic) IBOutlet UIButton *upVoteButton;
@property (weak, nonatomic) IBOutlet UILabel *upVoteLabel;
@property (weak, nonatomic) IBOutlet UIButton *downVoteButton;
@property (weak, nonatomic) IBOutlet UILabel *downVoteLabel;

@property (nonatomic, strong) DUNTimelineUserMessage *message;

@end
