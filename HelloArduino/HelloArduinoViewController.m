//
//  HelloArduinoViewController.m
//  HelloArduino
//
//  Created by Brian Jepson on 7/16/11.
//  Copyright 2011 O'Reilly Media. All rights reserved.
//

#import "HelloArduinoViewController.h"

@implementation HelloArduinoViewController
@synthesize toggleSwitch;//, response;

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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                    message:@"Button Pressed"
                                                   delegate:nil 
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
   

    if (toggleSwitch.on) { // check the state of the button
        //send an array
        txBuffer[0] = 30;
        txBuffer[1] = true;
        txBuffer[2] = true;
        txBuffer[3] = true;
        txBuffer[4] = true;
        txBuffer[5] = 30;
        txBuffer[6] = true;
        txBuffer[7] = true;
        txBuffer[8] = true;
        txBuffer[9] = true;
        
        
    
    
    } else {
         //send an array
        txBuffer[0] = 0;
        txBuffer[1] = false;
        txBuffer[2] = false;
        txBuffer[3] = false;
        txBuffer[4] = false;
        txBuffer[5] = 0;
        txBuffer[6] = false;
        txBuffer[7] = false;
        txBuffer[8] = false;
        txBuffer[9] = false;
    
    }
    
    // Send 0 or 1 to the Arduino
	[rscMgr write:txBuffer Length:10];  
    
    [alert show];
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

- (void) readBytesAvailable:(UInt32)numBytes {
    UInt8 rxBuffer[BUFFER_LEN];
 
    if (var == true) {
        return;
    }
  int bytes = [rscMgr read:rxBuffer Length:numBytes];

    
  NSString *response = [[NSString alloc]initWithFormat:@"%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i --- %i ", 
                          (int)rxBuffer[0],
                          (int)rxBuffer[1],
                          (int)rxBuffer[2],
                          (int)rxBuffer[3],
                          (int)rxBuffer[4],
                          (int)rxBuffer[5],
                          (int)rxBuffer[6],
                          (int)rxBuffer[7],
                          (int)rxBuffer[8],
                          (int)rxBuffer[9],
                          (int)rxBuffer[10],
                          (int)rxBuffer[11],
                          (int)rxBuffer[12],
                          (int)rxBuffer[13],
                          (int)rxBuffer[14],
                          (int)rxBuffer[15], 
                            bytes];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                    message:response
                                                   delegate:nil 
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];

    var = true;
}

- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    return FALSE;    
}

- (void) didReceivePortConfig {
}

@end
