//
//  sampleViewController.h
//  sample
//
//  Created by Mujtaba Mehdi on 9/15/11.
//  Copyright 2011 http://www.codesignerror.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "SA_OAuthTwitterEngine.h"
#import "ResultViewContoller.h"
#import "Global.h"
@interface sampleViewController : UIViewController<ZXingDelegate> {
    IBOutlet UILabel *resultLbl;

}
@property(nonatomic,retain) IBOutlet UILabel *resultLbl;
- (IBAction)scanPressed:(id)sender;

@end