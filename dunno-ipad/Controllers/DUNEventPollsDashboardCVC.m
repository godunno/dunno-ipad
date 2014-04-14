#import "DUNEventPollsDashboardCVC.h"
#import "DUNDashboardPollCell.h"

#import "DUNPoll.h"

#import "DUNSession.h"
#import "DUNAPI.h"

#import <SDCAlertView/SDCAlertView.h>

@interface DUNEventPollsDashboardCVC ()
@property (nonatomic, strong) DUNSession *session;
@end

@implementation DUNEventPollsDashboardCVC

-(void)viewDidLoad
{
  [super viewDidLoad];
  _session = [DUNSession sharedInstance];
  self.collectionView.backgroundColor = [UIColor whiteColor];
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
  DUNPoll *poll = _session.activeEvent.polls[indexPath.row];
  
  if(poll.status == DUNPollReleased) {
    return;
  }
  
  [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor redColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  DUNPoll *poll = _session.activeEvent.polls[indexPath.row];
  
  if(poll.status == DUNPollReleased) {
    return;
  }

  [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor greenColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  DUNPoll *poll = _session.activeEvent.polls[indexPath.row];
  
  if(poll.status == DUNPollReleased) {
    return;
  }
  
  [[DUNAPI sharedInstance] releasePoll:poll success:^{
    
    [_session releasePollAtCurrentEvent:poll];
    [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor redColor];
    
  } error:^(NSError *error) {
    SDCAlertView *alertView = [[SDCAlertView alloc] initWithTitle:@"ERRO" message:@"Não foi possível lançar a enquete." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
  }];
  
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
  
  DUNPoll *poll = _session.activeEvent.polls[indexPath.row];
  
  cell.answerTextView.text = poll.content;
  
  return cell;
}

@end
