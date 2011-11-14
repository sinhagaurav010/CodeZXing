//
//  sampleAppDelegate.h
//  sample
//
//  Created by Mujtaba Mehdi on 9/15/11.
//  Copyright 2011 http://www.codesignerror.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

#define  AppIDAPI @"308790145802337"

@class sampleViewController;

@interface sampleAppDelegate : NSObject <UIApplicationDelegate,FBSessionDelegate> {
    Facebook *facebook;
}
@property (retain, nonatomic) Facebook * facebook;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet sampleViewController *viewController;

@end
