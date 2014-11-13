//
//  RFSListaPedidos.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSListaPedidos.h"

@interface RFSListaPedidos ()

@end

@implementation RFSListaPedidos

- (void)viewDidLoad {
    [super viewDidLoad];

    self.client = [RFSClient sharedClient];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:@"reload_data" object:nil];
    [self carregarItens];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) carregarItens {
  self.pedidos = [[NSMutableArray alloc] init];
  [self.client listaPedidosWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
    for (NSDictionary *item in responseObject) {
      RFSPedido * pedido = [[RFSPedido alloc] init];
      pedido.produto = [[RFSProduto alloc] init];
      pedido.produto.nome = item[@"product_name"];
      pedido.produto.identifier = item[@"product_id"];
      pedido.quantidade = item[@"amount"];
      [self.pedidos addObject:pedido];
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
  cell.detailTextLabel.text = itemAtual.quantidade;
  return cell;
}

-(void)handle_data {
  [self carregarItens];
  [self.tabelaPedidos reloadData];
}

- (IBAction)realizarPagamento:(UISegmentedControl *)sender {
//  NSString *tipo = [[NSString alloc] initWithFormat:@"%il", (long)[self.tipoPagamento selectedSegmentIndex] ];
  NSString *tipo = [NSString stringWithFormat:@"%ld", (long)[self.tipoPagamento selectedSegmentIndex]];
  [self.client pagarCom:tipo withSuccess:^(NSURLSessionDataTask *task, id responseObject) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
  } orFailure:^(NSURLSessionDataTask *task, NSError *error) {
    // TODO
  }];
  
}
@end
