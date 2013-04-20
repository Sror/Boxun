//
//  PreviousViewController.h
//  Baker
//
//  Created by kiddz on 13-2-4.
//
//

#import <UIKit/UIKit.h>

@interface PreviewViewController : UIViewController<UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString *loadURL;

@end
