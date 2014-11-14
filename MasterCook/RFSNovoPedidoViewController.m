//
//  RFSNovoPedidoViewController.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSNovoPedidoViewController.h"
#import "TSMessage.h"
#import "RFSListaPedidos.h"

@interface RFSNovoPedidoViewController ()

@end

@implementation RFSNovoPedidoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [RFSClient sharedClient];
    // Do any additional setup after loading the view.
    self.labelNome.text = self.produto.nome;
    self.labelPreco.text = self.produto.preco;
    self.labelCategoria.text = self.produto.categoria;
}

- (IBAction)salvarPedido:(id)sender {
  RFSPedido *pedido = [[RFSPedido alloc] init];
  pedido.produto = self.produto;
  pedido.quantidade = self.textQuantidade.text;

  [self.client criaPedido:pedido withSuccess:^(NSURLSessionDataTask *task, id responseObject) {
    [TSMessage showNotificationWithTitle:@"Sucesso!"
                                subtitle:@"Pedido realizado com sucesso!"
                                    type:TSMessageNotificationTypeSuccess];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
    [self.navigationController popToRootViewControllerAnimated:YES];

  } orFailure:^(NSURLSessionDataTask *task, NSError *error) {
    // TODO
  }];

}


@end
