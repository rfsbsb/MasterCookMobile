//
//  RFSPedido.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSPedido.h"

@implementation RFSPedido

-(id)initWithNomeProduto:(NSString *)nomeProduto andIdProduto:(NSString*)produtoId andPrecoProduto:(NSString*)preco andQuantidade:(NSString *)quantidade andUser:(NSString *)usuario_id {
  RFSProduto *produto = [[RFSProduto alloc] init];
  produto.nome = nomeProduto;
  produto.identifier = produtoId;
  produto.preco = preco;
  self.produto = produto;
  self.quantidade = quantidade;
  self.usuario_id = usuario_id;
  return self;
}

@end
