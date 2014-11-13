//
//  RFSProduto.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 12/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFSProduto : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *preco;
@property (strong, nonatomic) NSString *categoria;
@property (strong, nonatomic) NSURL *foto;

- (id)initWithNome:(NSString *)nome andPreco:(NSString *)preco andCategoria:(NSString *)categoria andFoto:(NSString *)foto andId:(NSString*)identifier;

@end
