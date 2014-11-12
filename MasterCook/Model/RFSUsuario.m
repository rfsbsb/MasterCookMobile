//
//  RFSUsuario.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 11/11/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSUsuario.h"

@implementation RFSUsuario

-(id)initWithNome:(NSString *)nome andToken:(NSString *)token {
  self.nome = nome;
  self.token = token;
  return self;
}

@end
