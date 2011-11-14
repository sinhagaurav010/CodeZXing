//
//  ResultViewContoller.m
//  ScanTest
//
//  Created by Rohit Dhawan on 11/11/11.
//  Copyright (c) 2011 rohit@bosswebtech.com. All rights reserved.
//

#import "ResultViewContoller.h"
#import "SA_OAuthTwitterEngine.h"

@implementation ResultViewContoller
@synthesize stringURL;
@synthesize facebook = _facebook;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(IBAction)enail:(id)sender
{
    [self clickOn:nil withMessage:self.stringURL];
}
#define mark -Mail Composer-

-(void)clickOn:(NSString *)stringEmailId withMessage:(NSString *)strMsg
{
    //NSLog(@"clickon");
	NSArray *arrayRec = [NSArray arrayWithObjects:stringEmailId,nil];
    //NSLog(@"%d",[MFMailComposeViewController canSendMail]);
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
		//[mcvc setSubject:EMAILSUB];
		[mcvc setToRecipients:arrayRec];
        
        
        //		NSString *messageBdy = [NSString stringWithFormat:@"Name %@<br>Phone %@ <br>Address %@<br>%@<br>City %@ <br>%@<br> %@<br>special features%@",textname.text,textphone.text,textAddress.text,buttonTime.titleLabel.text,textCity.text,buttonBed.titleLabel.text,buttonBath.titleLabel.text,textfea.text];
        
        [mcvc setMessageBody:strMsg    isHTML:NO];
		
        //[mcvc addAttachmentData:UIImageJPEGRepresentation(imageToEmail, 1.0f) mimeType:@"image/jpeg" fileName:@"pickerimage.jpg"];
		[self presentModalViewController:mcvc animated:YES];
	}	
    else
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                           message:@"Please Configure Email" 
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles: nil];
        [alerView show];
        [alerView release];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    isFirstScan = 1;
    
    sampleAppDelegate *appDelegate = (sampleAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [webViewResult   loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringURL]]];
    
    _facebook = appDelegate.facebook;
   
    _permissions =  [[NSArray arrayWithObjects:
                      @"read_stream", @"publish_stream", @"offline_access",@"email",@"user_birthday",@"user_photos",nil] retain];
       
    _fbButton.isLoggedIn = NO;
    //_fbButton.
    [_fbButton updateImage];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)login {
    NSLog(@"Login Press");
    [_facebook authorize:_permissions delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [_facebook logout:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (IBAction)fbButtonClick:(id)sender {
    if (_fbButton.isLoggedIn) {
        [self logout];
    } else {
        [self login];
    }
}

/**
 * Make a Graph API Call to get information about the current logged in user.
 */
//- (IBAction)getUserInfo:(id)sender {
//    [_facebook requestWithGraphPath:@"me" andDelegate:self];
//}


/**
 * Make a REST API call to get a user's name using FQL.
 */
- (IBAction)getPublicInfo:(id)sender {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"SELECT uid,name FROM user WHERE uid=4", @"query",
                                    nil];
    [_facebook requestWithMethodName:@"fql.query"
                           andParams:params
                       andHttpMethod:@"POST"
                         andDelegate:self];
}

/**
 * Open an inline dialog that allows the logged in user to publish a story to his or
 * her wall.
 */
- (IBAction)publishStream:(id)sender {
    
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           @"Always Running",@"text",@"http://itsti.me/",@"href", nil], nil];
    
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"a long run", @"name",
                                
                                @"The Facebook Running app", @"caption",
                                @"it is fun", @"description",
                                @"http://itsti.me/", @"href", nil];
    NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Share on Facebook",  @"user_message_prompt",
                                   actionLinksStr, @"action_links",
                                   attachmentStr, @"attachment",
                                   nil];
    
    
    [_facebook dialog:@"feed"
            andParams:params
          andDelegate:self];
    
}
- (void)publishFeed{
	
    //	categoryListArray = [[CategoryDataDict objectForKey:[keyArray objectAtIndex:whichSectionSelected]] copy];
    //	
    //	NSLog(@"[CategoryDataDict allValues] = %@",categoryListArray);
    //	[[categoryListArray objectAtIndex:whichRowSelected]getValue:&catDataStruct];
	
	//titleLabel.text = [NSString stringWithFormat:@"%@",p.newsTitle];
	//descriptionLabel.text = [NSString stringWithFormat:@"%@",p.newsDescription];
	//dateAndTimeLabel.text = [NSString stringWithFormat:@"%@",p.newsPubDate];
    //	NSString *tid=[NSString stringWithFormat:@"%l", _session.uid];
    //	NSString *body = [dictInfo objectForKey:FIELDDESC];
    //    //	if (isShareMail) {
    //    //		body = [NSString stringWithFormat:@"%@",[self flattenHTML:[detailsDictionary objectForKey:@"description"]]];
    //    //	}else {
    //    //		body = [NSString stringWithFormat:@"%@",[self flattenHTML:[[dealsDataArray objectAtIndex:dealsMailShowIndex] objectForKey:@"dealDetails"]]];
    //    //	}
    //	
    //	
    //    //  NSString *body    = [NSString stringWithFormat:@"%@",[self flattenHTML:[detailsDictionary objectForKey:@"description"]]];
    //	
    //	//  NSString *body    = @"This News is posted through News Paper App";
    //	
    //	//  float latitude = appDelegate.currentLocation.coordinate.latitude;
    //	//  float longitude = appDelegate.currentLocation.coordinate.longitude;
    //	
    //	// NSString *attach = [NSString stringWithFormat:@"{\"name\":\"Here I Am\",\"href\":\"http://maps.google.com/?q=%f,%f\",\"latitude\":\"%f\",\"longitude\":\"%f\",\"description\":\"Shared using GeoMashable on the iPad\",\"media\":[{\"type\":\"image\",\"src\":\"http://www.geomashable.com/images/icon.png\",\"href\":\"http://www.geomashable.com\"}],\"properties\":{\"Download\":{\"text\":\"Click here to Download now\",\"href\":\"http://www.geomashable.com\"}}}",latitude,longitude,latitude,longitude];
    //	
    //	// NSString *actionLinks = @"[{\"text\":\"iPhone\",\"href\":\"http://www.geomashable.com\"}]";
    //	// NSArray *obj = [NSArray arrayWithObjects:body,attach,actionLinks,[NSString stringWithFormat:@"%@", tid],nil];
    //	// NSArray *keys = [NSArray arrayWithObjects:@"message",@"attachment",@"action_links",@"target_id",nil];
    //	NSString *actionLinks = @"[{\"text\":\"iPhone\",\"href\":\"http://www.google.com\"}]";
    //	
    //	
    //    NSArray *obj = [NSArray arrayWithObjects:body,actionLinks,[NSString stringWithFormat:@"%@", tid],nil];
    //    NSArray *keys = [NSArray arrayWithObjects:@"message",@"action_links",@"target_id",nil];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjects:obj forKeys:keys];
    //    [[FBRequest requestWithDelegate:self] call:@"facebook.stream.publish" params:params];
}
- (void)fbDidLogin {
    
    NSLog(@"fbLogin");
    _fbButton.isLoggedIn = YES;
    [_fbButton updateImage];
    // FBRequest *request = [[FBRequest alloc] init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Posting...";
    //
    //    
    //    
    //    request = [_facebook requestWithGraphPath:@"me" andDelegate:self];
    NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
    
    //[variables setObject:@"http://farm6.static.flickr.com/5015/5570946750_a486e741.jpg" forKey:@"link"];
    //[variables setObject:@"http://farm6.static.flickr.com/5015/5570946750_a486e741.jpg" forKey:@"picture"];
    [variables setObject:@"You scored 99999" forKey:@"name"];
    [variables setObject:@" " forKey:@"caption"];
    [variables setObject:[NSString stringWithFormat:@"%@",self.stringURL] forKey:@"message"];
    
    [_facebook requestWithMethodName:@"stream.publish" andParams:variables andHttpMethod:@"POST" andDelegate:self];
}
/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    
    _fbButton.isLoggedIn         = NO;
    [_fbButton updateImage];
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Success"
                                                     message:@"Posted to FaceBook"
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
    [alert release];}

-(IBAction)twitterShare:(id)sender
{
    NSLog(@"here is ");
    
    
    if(!_engine)
    {
        
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];  
        _engine.consumerKey    = kOAuthConsumerKey;  
        _engine.consumerSecret = kOAuthConsumerSecret;  
        
    } 
        
    if(![_engine isAuthorized])
    {  
        NSLog(@"here is creashig");
    
        UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];  
        NSLog(@"here is creashig");
        if (controller)
        {
            NSLog(@"here is creashig");
            [self presentModalViewController: controller animated: YES];  
            NSLog(@"not crashing.");
        } 
        
    }    
}

#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
     [_engine sendUpdate:self.stringURL];
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
    [_engine sendUpdate:self.stringURL];

	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
    
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                     message:@"Please check NetWork Setting"
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [alert show];
    [alert release];

	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
