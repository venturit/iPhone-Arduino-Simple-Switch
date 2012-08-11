//
//  HelloArduinoViewController.m
//  HelloArduino
//
//  Created by Brian Jepson on 7/16/11.
//  Copyright 2011 O'Reilly Media. All rights reserved.
//

#import "HelloArduinoViewController.h"

@implementation HelloArduinoViewController
@synthesize toggleSwitch, response, input;

- (void)dealloc
{
    [toggleSwitch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    rscMgr = [[RscMgr alloc] init]; 
    [rscMgr setDelegate:self];
    var = false;
    [response setText:@"Initializing..."];
}


- (void)viewDidUnload
{
    [self setToggleSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)toggleLED:(id)sender {

    if (toggleSwitch.on) { 
        
        txBuffer[0] = 160; //KeyValue
        txBuffer[1] = 21;
        txBuffer[2] = 31;
        txBuffer[3] = 41;
        txBuffer[4] = 51;
        txBuffer[5] = 62;
        txBuffer[6] = 71;
        txBuffer[7] = 81;
        txBuffer[8] = 91;

        
       
    
    
    } else {
        
        txBuffer[0] = 110; //KeyValue
        txBuffer[1] = 20;
        txBuffer[2] = 30;
        txBuffer[3] = 40;
        txBuffer[4] = 50;
        txBuffer[5] = 65;
        txBuffer[6] = 70;
        txBuffer[7] = 80;
        txBuffer[8] = 90;
       
     
    
    }
    [rscMgr write:(txBuffer) Length:9];  

}

#pragma mark - RscMgrDelegate methods

- (void) cableConnected:(NSString *)protocol {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                    message:@"Connected"
                                                   delegate:nil 
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
 


    [rscMgr setBaud:9600];
	[rscMgr open]; 
    
    [alert show];
}

- (void) cableDisconnected {
	
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                    message:@"Disconnected"
                                                   delegate:nil 
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];

    
}

- (void) portStatusChanged {
    
}

- (void) readBytesAvailable:(UInt32)bytesRead {
    
    [rscMgr read:rxBuffer Length:bytesRead];
    
    NSString *output = [[NSString alloc] initWithBytes:rxBuffer length:bytesRead encoding: NSUTF8StringEncoding];
    
    
    if ([output characterAtIndex:0 == '[' ]) {
        [input copy:output];
    }else {
        [input stringByAppendingString:output];

        if ([output hasPrefix:@"]"]) {
            //process data
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                            message:input
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }

}

- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    return FALSE;    
}

- (void) didReceivePortConfig {
}

@end
