//
//  RFSClient.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 05/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSClient.h"

NSString * const urlBase = @"http://localhost:3000";

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

@end