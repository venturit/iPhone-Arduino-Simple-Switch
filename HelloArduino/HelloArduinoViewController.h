//
//  HelloArduinoViewController.h
//  HelloArduino
//
//  Created by Brian Jepson on 7/16/11.
//  Copyright 2011 O'Reilly Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RscMgr.h"

#define BUFFER_LEN 4096

@interface HelloArduinoViewController : UIViewController <RscMgrDelegate> {
    
    RscMgr *rscMgr;
    //UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    UInt8 rxBuffer[BUFFER_LEN];
    UISwitch *toggleSwitch;
    NSMutableString *input;
    bool var;
   
    UILabel *response;
}
@property (nonatomic, retain) IBOutlet UILabel *response;
@property (nonatomic, retain)  NSMutableString *input;
@property (nonatomic, retain) IBOutlet UISwitch *toggleSwitch;
- (IBAction)toggleLED:(id)sender;

@end
