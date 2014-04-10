#import "DUNEventTimelineTVC.h"
#import "DUNTimelineMessageCell.h"
#import "DUNTimelineHeaderView.h"

#import "DUNTopic.h"

#import "DUNSession.h"

@interface DUNEventTimelineTVC ()
@property (nonatomic, strong) DUNSession *session;
@end

@implementation DUNEventTimelineTVC


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _session = [DUNSession sharedInstance];
  
  [_session subscribeTimelineChangesObserver:self execute:^(DUNTimeline *timeline) {
    [self.tableView reloadData];
  }];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_session.activeEvent.timeline.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DUNTimelineMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kDUNTimelineMessageCellRestorationId];
  
  DUNTimelineUserMessage *message = [_session.activeEvent.timeline.messages objectAtIndex:indexPath.row];
  
  [cell setMessage:message];
  
  return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

@end
