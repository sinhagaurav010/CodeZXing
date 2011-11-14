//
//  sampleViewController.m
//  sample
//
//  Created by Mujtaba Mehdi on 9/15/11.
//  Copyright 2011 http://www.codesignerror.com All rights reserved.
//

#import "sampleViewController.h"
#import "QRCodeReader.h"

@implementation sampleViewController
@synthesize resultLbl;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)scanPressed:(id)sender {
    
}
#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    [self dismissModalViewControllerAnimated:NO];
    
    if ([result length]>0) {
        //[resultLbl setText:result];
        ResultViewContoller *ResultControlller = [[ResultViewContoller alloc] init];
        ResultControlller.stringURL = result;
        [self.navigationController pushViewController:ResultControlller animated:YES];
        
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@" Not valid bar code for this Application", @"") delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    if(isFirstScan == 1)
    {
    isFirstScan = 0;
    
    ZXingWidgetController *widController = [[[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO] autorelease];
    QRCodeReader* qrcodeReader = [[[QRCodeReader alloc] init] autorelease];
    NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
    widController.readers = readers;
    [readers release];
    [self presentModalViewController:widController animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
//    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
//    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
//    
//    NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
//    [qrcodeReader release];
//    
//    widController.readers = readers;
//    [readers release];
//    
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    
//    widController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
//    
//    [self presentModalViewController:widController animated:NO];
//    
//    [widController release];
    
}
#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
