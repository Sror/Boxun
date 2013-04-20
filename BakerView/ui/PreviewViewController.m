    //
//  PreviousViewController.m
//  Baker
//
//  Created by kiddz on 13-2-4.
//
//

#import "PreviewViewController.h"

@interface PreviewViewController ()
{
    IBOutlet UIWebView *_previewWebView;
    UITapGestureRecognizer *_tapGesture;
    UITapGestureRecognizer *_tapGesture2;
    
    IBOutlet UIButton  *_backBtn;
    IBOutlet UIButton  *_refreshBtn;
    IBOutlet UIButton  *_stopBtn;
    
    IBOutlet UIActivityIndicatorView *_activitor;
    
    NSArray *_btnArray;
    
    NSTimer *_timer;
}

@end

@implementation PreviewViewController

- (void)dealloc
{
    [_btnArray release];
    
    [self.loadURL release];
    [_previewWebView release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.loadURL) {
        NSLog(@"%@", self.loadURL);
        NSURL *URL = [NSURL URLWithString:self.loadURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [_previewWebView loadRequest:request];
    }
        
    _btnArray = [[NSArray alloc] initWithObjects:_backBtn, _refreshBtn, _stopBtn, nil];
}

- (void)viewWillAppear:(BOOL)animated
{   
    UIApplication *application = [UIApplication sharedApplication];
    [application setStatusBarHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIApplication *application = [UIApplication sharedApplication];
    [application setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)taped1time
{
    UIApplication *application = [UIApplication sharedApplication];
    if(!application.statusBarHidden){
        [application setStatusBarHidden:YES];
        [self.navigationController.navigationBar setHidden:YES];
        
        [self.view removeGestureRecognizer:_tapGesture];
        _tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped2times)];
        [_tapGesture2 setDelegate:self];
        [_tapGesture2 setCancelsTouchesInView:NO];
        [_tapGesture2 setNumberOfTapsRequired:2];
        [_tapGesture2 setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:_tapGesture2];
        [_tapGesture2 release];
    }
}

- (void)taped2times
{
    UIApplication *application = [UIApplication sharedApplication];
    if(application.statusBarHidden){
        [application setStatusBarHidden:NO];
        [self.navigationController.navigationBar setHidden:NO];
        
        [self.view removeGestureRecognizer:_tapGesture2];
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped1time)];
        [_tapGesture setDelegate:self];
        [_tapGesture setCancelsTouchesInView:NO];
        [_tapGesture setNumberOfTapsRequired:1];
        [_tapGesture setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:_tapGesture];
        [_tapGesture release];
    }
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"myweb"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
        {
            NSLog(@"%@",[components objectAtIndex:2]);
        }
        return NO;
    }
    return YES;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
//        UITouch *touch = (UITouch *)obj;
//        UIApplication *application = [UIApplication sharedApplication];
//        if(touch.tapCount == 2){
//            if(!application.statusBarHidden){
//                [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//                [self.navigationController setNavigationBarHidden:NO animated:YES];
//            }
//            
//        }else if(touch.tapCount == 1){
//            if(application.statusBarHidden){
//                [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//                [self.navigationController setNavigationBarHidden:YES animated:YES];
//            }
//        }
//    }];
//}
- (IBAction)buttonPressed:(id)sender {
    switch ([_btnArray indexOfObject:sender]) {
        case 0:
            [self popToRoot:sender];
            break;
         case 1:
            [_previewWebView reload];
            break;
        case 2:
            [_previewWebView stopLoading];
            break;
        default:
            break;
    }
    
}
- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches moved");
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)stopLoading
{
    [_previewWebView stopLoading];
    _activitor.hidden = YES;
}

#pragma mark- webview deletage
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    for (UIButton *btn in _btnArray) {
        [btn setHidden:NO];
    }
    [_stopBtn setHidden:NO];
    [_activitor setHidden:NO];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    for (UIButton *btn in _btnArray) {
        [btn setHidden:NO];
    }
    [_stopBtn setHidden:YES];
    [_activitor setHidden:YES];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

    for (UIButton *btn in _btnArray) {
        [btn setHidden:NO];
    }

}


@end
