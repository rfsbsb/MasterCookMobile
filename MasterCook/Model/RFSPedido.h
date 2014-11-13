//
//  RFSPedido.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFSProduto.h"

@interface RFSPedido : NSObject

@property (strong, nonatomic) NSString *quantidade;
@property (strong, nonatomic) NSString *usuario_id;
@property (strong, nonatomic) RFSProduto *produto;

@end
