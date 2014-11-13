//
//  RFSListaProdutos.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 12/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSClient.h"

@interface RFSListaProdutos : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) RFSClient *client;
@property (strong, nonatomic) NSMutableArray *produtos;
@property (nonatomic, weak) IBOutlet UITableView* tabelaProdutos;

@end
