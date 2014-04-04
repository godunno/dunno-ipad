#import "DUNEventDashboardVC.h"
#import "DUNTimelineMessageCell.h"
#import "DUNDashboardPollCell.h"

#import "DUNSession.h"

#import "DUNEvent.h"
#import "DUNPoll.h"


@interface DUNEventDashboardVC ()<UITableViewDelegate, UITableViewDataSource,
                                    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UITableView *timelineTableView;
@property (nonatomic, weak) IBOutlet UICollectionView *pollCollectionView;

@property (nonatomic, weak) IBOutlet UIButton *closeEventButton;

@property (nonatomic, strong) DUNSession *session;

@end

@implementation DUNEventDashboardVC

- (void)viewDidLoad
{
  [super viewDidLoad];

  //load and customize interface
    _session = [DUNSession sharedInstance];
  
  _timelineTableView.delegate = self;
  _timelineTableView.dataSource = self;
}

- (void) viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  NSParameterAssert(_session.currentTeacher!=nil);
  NSParameterAssert(_session.activeEvent!=nil);

}

- (IBAction)closeEvent:(id)sender
{
  
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_session.activeEvent.timeline.messages count];
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DUNTimelineMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kDUNTimelineMessageCell];
  
  DUNTimelineUserMessage *message = [_session.activeEvent.timeline.messages objectAtIndex:indexPath.row];
  
  cell.textLabel.text = @"opa";
  
  return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(50, 10, 50, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 50;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor redColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor lightGrayColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  //  DUNEvent *event = [[_session.currentTeacher events] objectAtIndex:indexPath.row];
  //release poll
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [_session.activeEvent.polls count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  DUNDashboardPollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDUNDashboardPollCellRestorationId forIndexPath:indexPath];
  
  DUNPoll *poll = [_session.activeEvent.polls objectAtIndex:indexPath.row];
  
  cell.answerTextView.text = poll.content;
  
  return cell;
}

@end
