//
//  RFSNovoPedidoViewController.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSClient.h"

@interface RFSNovoPedidoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelNome;
@property (weak, nonatomic) IBOutlet UILabel *labelCategoria;
@property (weak, nonatomic) IBOutlet UILabel *labelPreco;
@property (weak, nonatomic) IBOutlet UITextField *textQuantidade;
- (IBAction)salvarPedido:(id)sender;
@property (strong, nonatomic) RFSProduto *produto;
@property (strong, nonatomic) RFSClient *client;

@end
