//
//  RFSListaProdutos.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 12/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSListaProdutos.h"
#import "RFSNovoPedidoViewController.h"

@interface RFSListaProdutos ()

@end

@implementation RFSListaProdutos

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [RFSClient sharedClient];
    [self carregarItens];

}

/*
 * Carregando itens da tesouraria
 */
- (void) carregarItens {
  self.produtos = [[NSMutableArray alloc] init];
  [self.client listaProdutosWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
    for (NSDictionary *item in responseObject) {
      RFSProduto * produto = [[RFSProduto alloc] initWithNome:item[@"name"] andPreco:item[@"price"] andCategoria:item[@"category"] andFoto:item[@"photo"] andId:item[@"id"]];
      [self.produtos addObject:produto];
    }
    [self.tabelaProdutos reloadData];
  } orFailure:^(NSURLSessionDataTask *task, NSError *error) {
    // TODO
  }];

}

/*
 * Manualmente escondendo a barra de navegação
 */
- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:YES animated:animated];
  [super viewWillAppear:animated];
}

/*
 * Manualmente exibindo a barra de navegação quando sair
 */
- (void)viewWillDisappear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:NO animated:animated];
  [super viewWillDisappear:animated];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.produtos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celula" forIndexPath:indexPath];
    
    // Configure the cell...
    RFSProduto *itemAtual = self.produtos[indexPath.row];
    cell.textLabel.text = itemAtual.nome;
    cell.detailTextLabel.text = itemAtual.preco;

    // carregando as imagens assíncronamente
    NSURLRequest *request = [NSURLRequest requestWithURL:itemAtual.foto];
    __weak UITableViewCell *weakCell = cell;

    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                     weakCell.imageView.image = image;
                                     [weakCell setNeedsLayout];
                                   } failure:nil];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
  if ([[segue identifier] isEqualToString:@"novoPedido"]) {
    UIViewController *novo = [segue destinationViewController];
    RFSNovoPedidoViewController *novoController = (RFSNovoPedidoViewController *) novo;
    NSIndexPath *indexPath = [self.tabelaProdutos indexPathForSelectedRow];
    long row = [indexPath row];
    novoController.produto = self.produtos[row];
  }
}


@end
