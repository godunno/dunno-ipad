#import "DUNLoginVC.h"
#import "DUNHomeVC.h"

@interface DUNLoginVC ()

@end

@implementation DUNLoginVC

- (void)viewDidLoad
{
  [super viewDidLoad];
  
}

- (IBAction)doLogin:(id)sender
{
  DUNHomeVC *homeVC =  [self.storyboard instantiateViewControllerWithIdentifier:kDUNHomeVCStoryboardId];
  
  [self.splitViewController.viewControllers[1] pushViewController:homeVC animated:YES];
}
@end
