#import "DUNEventTimelineTVC.h"
#import "DUNTimelineMessageCell.h"
#import "DUNTimelineHeader.h"

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
  
  cell.textLabel.text = message.content;
  
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  DUNTimelineHeader *header = [[NSBundle mainBundle] loadNibNamed:kDUNTimelineHeaderNibName
                                                            owner:self
                                                          options:nil][0];
  
  if(_session.activeEvent.topics.count == 0){ // start point
    header.topicsTextView.text = @"Evento sem tópico específico - Tema livre";
  } else {
    __block NSString *topicsString = @"Tópicos do evento: \n\n";
    [_session.activeEvent.topics enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      DUNTopic *topic =(DUNTopic*)_session.activeEvent.topics[idx];
      topicsString = [topicsString stringByAppendingString:[@"\u2022 " stringByAppendingString:[topic.title stringByAppendingString:@"\n"]]];
    }];
    header.topicsTextView.text = topicsString;
  }
  
  return header;
}

#pragma mark -
#pragma mark - UITableViewDelegate

@end
