#import "DUNHomeVC.h"
#import "DUNEventCell.h"

#import "DUNCourse.h"
#import "DUNEvent.h"

#import "DUNAPI.h"
#import "DUNSession.h"
#import "DUNOpenEvent.h"

#import "DUNEventDashboardVC.h"

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

- (void) viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  NSParameterAssert(_session.currentTeacher!=nil);
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
  
  
  switch (event.status) {
    case DUNEventAvailable:
      [self open:event];
      break;
    case DUNEventOpened:
      [self enter:event];
      break;
    default:
      //TODO show message 'event closed' ?
      break;
  }
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

#pragma mark -
#pragma mark - Private Method

- (void) enter:(DUNEvent*)event
{
  NSLog(@"only enter");
}

- (void) open:(DUNEvent*)event
{
  DUNOpenEvent *openEventCommand = [[DUNOpenEvent alloc] initWithEvent:event];
  [openEventCommand executeOnSuccess:^(DUNEvent *eventOpened) {
    
    DUNEventDashboardVC *dashboardVC = [self.storyboard instantiateViewControllerWithIdentifier:kDUNEventDashboardVCStoryboardId];
    [self.navigationController pushViewController:dashboardVC animated:YES];
    
  } error:^(NSError *error) {
    SDCAlertView *alertView = [[SDCAlertView alloc] initWithTitle:@"ERRO" message:@"Problemas tentando abrir o Evento." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
  }];
}

@end
