#import "HelpViewController.h"

@interface HelpViewController ()<UIScrollViewDelegate>
@end

@implementation HelpViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = ScreenBounds;
    self.scrollview.frame = ScreenBounds;
    self.scrollview.contentSize = CGSizeMake(ScreenWidth*4,ScreenHeight);
    
    self.pic1.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.pic2.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    self.pic3.frame = CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight);
    self.pic4.frame = CGRectMake(ScreenWidth*3, 0, ScreenWidth, ScreenHeight);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enter)];
    self.pic4.gestureRecognizers = @[tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enter{
    NSNotification *notification=nil;
    notification=[NSNotification notificationWithName:@"kNOtificationShowLoginGuide" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView.contentOffset.x>self.pic4.left)
    {
        [self enter];
    }
}
@end
