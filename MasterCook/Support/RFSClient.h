//
//  RFSClient.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 05/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"
#import "RFSUsuario.h"

extern NSString * const urlBase;
extern RFSUsuario * usuarioLogado;

@interface RFSClient : AFHTTPSessionManager

@property (nonatomic, strong) RFSUsuario *usuarioLogado;

+ (RFSClient *)sharedClient;

- (void)logIn:(NSString *)usuario
        senha:(NSString *)senha
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
