//
//  RFSUsuario.h
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 11/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFSUsuario : NSObject
@property (strong, nonatomic) NSString *nome;
@property (strong, nonatomic) NSString *token;

- (id) initWithNome:(NSString *)nome andToken:(NSString *)token;

@end
