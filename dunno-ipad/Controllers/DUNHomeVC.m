#import "DUNHomeVC.h"
#import "DUNEventDashboardVC.h"
#import "DUNEventCell.h"

#import "DUNCourse.h"
#import "DUNEvent.h"

#import "DUNAPI.h"
#import "DUNSession.h"
#import "DUNOpenEvent.h"

#import <SDCAlertView/SDCAlertView.h>

@interface DUNHomeVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *eventsCollectionView;
@property (nonatomic, strong) DUNSession *session;
@end

@implementation DUNHomeVC

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _session = [DUNSession sharedInstance];
  
  _eventsCollectionView.delegate = self;
  _eventsCollectionView.dataSource = self;
  _eventsCollectionView.backgroundColor = [UIColor clearColor];
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
  DUNEvent *event = [[_session.currentTeacher events] objectAtIndex:indexPath.row];
  
  [[DUNAPI sharedInstance] openEvent:event success:^(DUNEvent *eventOpened) {
    
    DUNOpenEvent *openEventCommand = [[DUNOpenEvent alloc] initWithEvent:eventOpened];
    [openEventCommand execute];

    DUNEventDashboardVC *eventDashboardVC = [self.storyboard instantiateViewControllerWithIdentifier:kDUNDashboardEventVCStoryboardId];
    [self.navigationController presentViewController:eventDashboardVC animated:YES completion:nil];
    
  } error:^(NSError *error) {
    SDCAlertView *alertView = [[SDCAlertView alloc] initWithTitle:@"ERRO" message:@"Problemas tentando abrir o Evento." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
  }];
  
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [_session.currentTeacher events].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  DUNEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDUNEventCellReusableId forIndexPath:indexPath];
  DUNEvent *event = [[_session.currentTeacher events] objectAtIndex:indexPath.row];
  
  cell.eventName.text = event.uuid;
  
  return cell;
}

@end
