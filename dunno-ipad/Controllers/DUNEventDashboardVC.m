#import "DUNEventDashboardVC.h"
#import "DUNSession.h"

#import "DUNAPI.h"

#import "DUNEvent.h"

#import <SDCAlertView/SDCAlertView.h>

@interface DUNEventDashboardVC ()
@property (nonatomic, strong) DUNSession *session;
@end

@implementation DUNEventDashboardVC

- (void)viewDidLoad
{
  [super viewDidLoad];
  _session = [DUNSession sharedInstance];
}

- (void) viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  NSParameterAssert(_session.currentTeacher!=nil);
  NSParameterAssert(_session.activeEvent!=nil);
}

- (IBAction)closeEvent:(id)sender
{
  [[DUNAPI sharedInstance] closeEvent:_session.activeEvent success:^(DUNEvent *eventClosed) {
    
    [_session closeCurrentEvent];
    
    [self.navigationController popViewControllerAnimated:YES];
    
  } error:^(NSError *error) {
    SDCAlertView *alertView = [[SDCAlertView alloc] initWithTitle:@"ERRO" message:@"Username ou senha inválidos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
  }];
}


#pragma mark -
#pragma mark - Private Methods


@end
