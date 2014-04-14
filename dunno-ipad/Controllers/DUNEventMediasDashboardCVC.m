#import "DUNEventMediasDashboardCVC.h"
#import "DUNDashboardImageMediaCell.h"

#import "DUNSession.h"
#import "DUNAPI.h"

#import "DUNMedia.h"

#import <SDCAlertView/SDCAlertView.h>

@interface DUNEventMediasDashboardCVC ()
@property (nonatomic, strong) DUNSession *session;
@end

@implementation DUNEventMediasDashboardCVC

-(void)viewDidLoad
{
  [super viewDidLoad];
  _session = [DUNSession sharedInstance];
  self.collectionView.backgroundColor = [UIColor lightGrayColor];
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
  DUNMedia *media = _session.activeEvent.medias[indexPath.row];
  
  if(media.status == DUNMediaReleased) {
    return;
  }
  
  [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor grayColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  DUNMedia *media = _session.activeEvent.medias[indexPath.row];
  
  if(media.status == DUNMediaReleased) {
    return;
  }
  
  [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor blueColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  DUNMedia *media = _session.activeEvent.medias[indexPath.row];
  
  if(media.status == DUNMediaReleased) {
    return;
  }
  
  [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor grayColor];
  [[DUNAPI sharedInstance] releaseMedia:media success:^{
    
    [_session releaseMediaAtCurrentEvent:media];
    
  } error:^(NSError *error) {
    [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor blueColor];
    SDCAlertView *alertView = [[SDCAlertView alloc] initWithTitle:@"ERRO" message:@"Não foi possível lançar a mídia." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
  }];
  
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [_session.activeEvent.medias count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  DUNDashboardImageMediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDUNDashboardMediaCellRestorationId forIndexPath:indexPath];
  
  DUNMedia *media = _session.activeEvent.medias[indexPath.row];
  
  cell.titleLabel.text = media.title;
  
  return cell;
}


@end
