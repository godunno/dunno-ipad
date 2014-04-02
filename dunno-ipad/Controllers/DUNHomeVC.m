#import "DUNHomeVC.h"
#import "DUNEventCell.h"

#import "DUNCourse.h"
#import "DUNEvent.h"

#import "DUNSession.h"

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
  NSLog(@"click on event: %@", event.uuid);
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
