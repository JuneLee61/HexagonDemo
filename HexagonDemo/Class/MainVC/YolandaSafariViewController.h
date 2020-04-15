//
//  YolandaSafariViewController.h
//  YolandaOverSea
//
//  Created by DonYau on 2017/4/27.
//  Copyright © 2017年 Yolanda. All rights reserved.
//

#import <SafariServices/SafariServices.h>

@protocol YolandaSafariViewControllerDelegate <NSObject>

- (void)yolandaSafariViewControllerPopSwitchOn:(BOOL)switchStatus;

@end

API_AVAILABLE(ios(9.0))
@interface YolandaSafariViewController : SFSafariViewController

@property (nonatomic, weak) id<YolandaSafariViewControllerDelegate> yolandaSafariViewDelegate;



@end
