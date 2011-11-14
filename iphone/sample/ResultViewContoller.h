//
//  ResultViewContoller.h
//  ScanTest
//
//  Created by Rohit Dhawan on 11/11/11.
//  Copyright (c) 2011 rohit@bosswebtech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"
#import "Facebook.h"
#import "FBLoginButton.h"
#import "JSON.h"
#import "sampleAppDelegate.h"
#import "Global.h"
#import <MessageUI/MessageUI.h>

#define kOAuthConsumerKey @"CSJN8GrCXJZMse5PP1bfpw"		//REPLACE With Twitter App OAuth Key  
#define kOAuthConsumerSecret @"MVwwULmejhHmugf4mKii52mRORT3UJ6sILUllT5zeKY"	

#import "MBProgressHUD.h"

@class SA_OAuthTwitterEngine;


@interface ResultViewContoller : UIViewController<SA_OAuthTwitterControllerDelegate,FBSessionDelegate, FBRequestDelegate,FBDialogDelegate,MFMailComposeViewControllerDelegate>
{
    SA_OAuthTwitterEngine *_engine;
    

    IBOutlet UIButton *buttonFaceBook;
    NSArray* _permissions;
    IBOutlet FBLoginButton * _fbButton;
    

    IBOutlet UIWebView *webViewResult;
}

@property (retain, nonatomic) Facebook * facebook;
-(void)clickOn:(NSString *)stringEmailId withMessage:(NSString *)strMsg;

-(IBAction)faceBookSharing:(id)sender;
-(IBAction)enail:(id)sender;
-(IBAction)twitterShare:(id)sender;
@property(retain)NSString *stringURL;
@end
