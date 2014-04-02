#import "DUNLoginVC.h"
#import "DUNHomeVC.h"

#import "DUNAPI.h"
#import "DUNSession.h"

#import <SDCAlertView/SDCAlertView.h>

@interface DUNLoginVC ()
@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@end

@implementation DUNLoginVC

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (IBAction)doLogin:(id)sender
{
  NSString *username = _usernameTextField.text;
  NSString *password = _passwordTextField.text;
  
  [[DUNAPI sharedInstance] loginTeacherWithUsername:username andPassword:password success:^(DUNTeacher *teacher) {
    
    [DUNSession sharedInstance].currentTeacher = teacher;
    
    DUNHomeVC *homeVC =  [self.storyboard instantiateViewControllerWithIdentifier:kDUNHomeVCStoryboardId];
    [self.navigationController presentViewController:homeVC animated:YES completion:nil];
        
  } error:^(NSError *error) {
    
    SDCAlertView *alertView = [[SDCAlertView alloc] initWithTitle:@"ERRO" message:@"Username ou senha inválidos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
  }];
  
}
@end
