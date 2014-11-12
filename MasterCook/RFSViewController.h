//
//  RFSViewController.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/09/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSClient.h"
#import "TSMessage.h"

@interface RFSViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) RFSClient *client;

@property (weak, nonatomic) IBOutlet UITextField *usuario;
@property (weak, nonatomic) IBOutlet UITextField *senha;
- (IBAction)efetuarLogin:(UIButton *)sender;
- (IBAction)tocouView:(UIView *)sender;
- (IBAction)textFieldRetorno:(UITextField *)sender;
@end
