//
//  RFSClient.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 05/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSClient.h"

NSString * const urlBase = @"http://mastercook-env-3ypimc9hub.elasticbeanstalk.com";

@implementation RFSClient

/*
 * Implementando o Grand Central Dispatch
 * Todos os métodos dessa classe são executados assíncronamente usando a biblioteca AFNetworking
 */
+ (RFSClient *)sharedClient {
  static RFSClient *_sharedClient = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlBase]];
  });
  return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
  self.usuarioLogado = [[RFSUsuario alloc] init];
  self = [super initWithBaseURL:url];
  if (!self) {
    return nil;
  }

  self.responseSerializer = [AFJSONResponseSerializer serializer];
  self.requestSerializer = [AFJSONRequestSerializer serializer];
  return self;
}

-(void)logIn:(NSString *)usuario senha:(NSString *)senha success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {

  NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:usuario, @"session[email]", senha, @"session[password]", nil];

  NSString *path = [NSString stringWithFormat:@"%@/login.json", urlBase];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager POST:path parameters:userData success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (success) {
      success(operation, responseObject);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    if (failure) {
      failure(operation, error);
    }
  }];

}

/*
 * Buscar os produtos
 */
-(void)listaProdutosWithSuccess:(void (^)(NSURLSessionDataTask *, id))success orFailure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

  NSString* path = [NSString stringWithFormat:@"products.json"];
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.usuarioLogado.nome, @"user_email", self.usuarioLogado.token, @"user_token", nil];

  [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    if (success) {
      success(task, responseObject);
    }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    if (failure) {
      failure(task, error);
    }
  }];
}

- (void)criaPedido:(RFSPedido *)pedido withSuccess:(void (^)(NSURLSessionDataTask *, id))success orFailure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

  NSString* path = [NSString stringWithFormat:@"orders.json"];
  NSMutableDictionary *orderParam = [[NSMutableDictionary alloc] initWithObjectsAndKeys:pedido.produto.identifier, @"product_id", pedido.quantidade, @"amount", nil];
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.usuarioLogado.nome, @"user_email", self.usuarioLogado.token, @"user_token", orderParam, @"order", nil];

  [self POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    if (success) {
      success(task, responseObject);
    }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    if (failure) {
      failure(task, error);
    }
  }];
}

/*
 * Buscar os produtos
 */
-(void)listaPedidosWithSuccess:(void (^)(NSURLSessionDataTask *, id))success orFailure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

  NSString* path = [NSString stringWithFormat:@"orders.json"];
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.usuarioLogado.nome, @"user_email", self.usuarioLogado.token, @"user_token", nil];

  [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    if (success) {
      success(task, responseObject);
    }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    if (failure) {
      failure(task, error);
    }
  }];
}

/*
 * Buscar os produtos
 */
-(void)obterProduto:(NSString*)produto withSuccess:(void (^)(NSURLSessionDataTask *, id))success orFailure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

  NSString* path = [NSString stringWithFormat:@"product/%@.json", produto];
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.usuarioLogado.nome, @"user_email", self.usuarioLogado.token, @"user_token", nil];

  [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    if (success) {
      success(task, responseObject);
    }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    if (failure) {
      failure(task, error);
    }
  }];
}

/*
 * Buscar os produtos
 */
-(void)pagarCom:(NSString*)tipo withSuccess:(void (^)(NSURLSessionDataTask *, id))success orFailure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

  NSString* path = [NSString stringWithFormat:@"orders/pay.json"];
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.usuarioLogado.nome, @"user_email", self.usuarioLogado.token, @"user_token", tipo, @"payment_mode", nil];

  [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    if (success) {
      success(task, responseObject);
    }
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    if (failure) {
      failure(task, error);
    }
  }];
}

@end
