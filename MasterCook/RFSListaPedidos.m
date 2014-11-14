//
//  RFSListaPedidos.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSListaPedidos.h"
#import "TSMessage.h"

@interface RFSListaPedidos ()

@end

@implementation RFSListaPedidos

- (void)viewDidLoad {
    [super viewDidLoad];

    self.client = [RFSClient sharedClient];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:@"reload_data" object:nil];
    [self carregarItens];
}

- (void) carregarItens {
  self.pedidos = [[NSMutableArray alloc] init];
  [self.tipoPagamento setSelectedSegmentIndex:UISegmentedControlNoSegment];
  [self.client listaPedidosWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
    for (NSDictionary *item in responseObject) {
      RFSPedido * pedido = [[RFSPedido alloc] initWithNomeProduto:item[@"product_name"] andIdProduto:item[@"product_id"]  andPrecoProduto:item[@"product_price"] andQuantidade:item[@"amount"] andUser:nil];
      [self.pedidos addObject:pedido];
    }
    if ([self.pedidos count] <= 0) {
      [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:nil];
      [self.tipoPagamento setUserInteractionEnabled:false];
    } else {
      NSString *numOfItems = [NSString stringWithFormat:@"%ld", [self.pedidos count]];
      [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:numOfItems];
      [self.tipoPagamento setUserInteractionEnabled:true];
    }
    [self.tabelaPedidos reloadData];
  } orFailure:^(NSURLSessionDataTask *task, NSError *error) {
    // TODO
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.pedidos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celulaPedidos" forIndexPath:indexPath];

  RFSPedido *itemAtual = self.pedidos[indexPath.row];
  cell.textLabel.text = itemAtual.produto.nome;
  float total = [itemAtual.produto.preco floatValue] * [itemAtual.quantidade integerValue];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"R$ %@ x %@ = R$ %.02f", itemAtual.produto.preco, itemAtual.quantidade, total];
  return cell;
}

-(void)handle_data {
  [self carregarItens];
  [self.tabelaPedidos reloadData];
}

- (IBAction)realizarPagamento:(UISegmentedControl *)sender {
  NSString *tipo = [NSString stringWithFormat:@"%ld", (long)[self.tipoPagamento selectedSegmentIndex]];
  [self.client pagarCom:tipo withSuccess:^(NSURLSessionDataTask *task, id responseObject) {
    [TSMessage showNotificationWithTitle:@"Sucesso!"
                                subtitle:@"Pedido realizado com sucesso!"
                                    type:TSMessageNotificationTypeSuccess];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
  } orFailure:^(NSURLSessionDataTask *task, NSError *error) {
    // TODO
  }];
  
}
@end
