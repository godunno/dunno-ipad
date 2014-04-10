#import "DUNTimelineHeaderView.h"
#import "DUNTopic.h"

@implementation DUNTimelineHeaderView

- (void)layoutSubviews
{
  [super layoutSubviews];
  DUNSession *session = [DUNSession sharedInstance];
  
  if(session.activeEvent.topics.count == 0){ // start point
    _topicsTextView.text = @"Evento sem tópico específico - Tema livre";
  } else {
    __block NSString *topicsString = @"Tópicos do evento: \n\n";
    [session.activeEvent.topics enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      DUNTopic *topic =(DUNTopic*)session.activeEvent.topics[idx];
      topicsString = [topicsString stringByAppendingString:[@"\u2022 " stringByAppendingString:[topic.title stringByAppendingString:@"\n"]]];
    }];
    _topicsTextView.text = topicsString;
  }
  
}

@end
