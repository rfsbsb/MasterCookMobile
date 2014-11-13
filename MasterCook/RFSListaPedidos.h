//
//  RFSListaPedidos.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSClient.h"

@interface RFSListaPedidos : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabelaPedidos;
@property (strong, nonatomic) NSMutableArray *pedidos;
@property (strong, nonatomic) RFSClient *client;
- (IBAction)realizarPagamento:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoPagamento;

@end
