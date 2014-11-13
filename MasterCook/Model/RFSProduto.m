//
//  RFSProduto.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 12/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSProduto.h"
#import "RFSClient.h"
@implementation RFSProduto


- (id)initWithNome:(NSString *)nome andPreco:(NSString *)preco andCategoria:(NSString *)categoria andFoto:(NSString *)foto andId:(NSString *) identifier{
  RFSClient *client = [RFSClient sharedClient];
  self.identifier = identifier;
  self.nome = nome;
  self.preco = preco;
  self.categoria = categoria;
  NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@", client.baseURL, foto];
  NSURL *fotoURL = [[NSURL alloc] initWithString:urlString];
  self.foto = fotoURL;
  return self;
}

@end
