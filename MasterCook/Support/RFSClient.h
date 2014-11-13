//
//  RFSClient.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 05/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "RFSUsuario.h"
#import "RFSPedido.h"


extern NSString * const urlBase;
extern RFSUsuario * usuarioLogado;

@interface RFSClient : AFHTTPSessionManager

@property (nonatomic, strong) RFSUsuario *usuarioLogado;

+ (RFSClient *)sharedClient;

- (void)logIn:(NSString *)usuario
        senha:(NSString *)senha
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)listaProdutosWithSuccess:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                    orFailure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)criaPedido:(RFSPedido *)pedido
          withSuccess:(void(^)(NSURLSessionDataTask *task, id responseObject))success
          orFailure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)listaPedidosWithSuccess:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                       orFailure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

-(void)obterProduto:(NSString*)produto
        withSuccess:(void(^)(NSURLSessionDataTask *task, id responseObject))success
          orFailure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)pagarCom:(NSString*)tipo withSuccess:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                      orFailure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
