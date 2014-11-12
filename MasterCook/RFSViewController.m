//
//  RFSViewController.m
//  MasterCook
//
//  Created by Rafael Ferreira Silva on 13/09/14.
//  Copyright (c) 2014 Rafael Ferreira Silva. All rights reserved.
//

#import "RFSViewController.h"

@interface RFSViewController ()

@end

@implementation RFSViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.client = [RFSClient sharedClient];
  self.usuario.delegate = self;
  self.senha.delegate = self;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)efetuarLogin:(UIButton *)sender {
  NSString *usuario = self.usuario.text;
  NSString *senha = self.senha.text;
  
  // como todos os acessos são assíncronos, tratamos cada um após o processamento
  [self.client logIn:usuario senha:senha success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if ([responseObject objectForKey:@"authentication_token"]) {
      self.client.usuarioLogado = [[RFSUsuario alloc] initWithNome:responseObject[@"email"] andToken:responseObject[@"authentication_token"]];
      // Depois de logado, mudamos para outra sequencia de telas
      // indo para as abas
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      UITabBarController *obj = [storyboard instantiateViewControllerWithIdentifier:@"abas"];
      [self.navigationController pushViewController:obj animated:YES];
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [TSMessage showNotificationWithTitle:@"Erro!"
                                subtitle:@"Usuário e/ou senha inválidos."
                                    type:TSMessageNotificationTypeError];
  }];
}

/*
 * Escondendo o teclado
 */
- (void)textFieldRetorno:(UITextField *)sender {
  [sender resignFirstResponder];
}

/*
 * Escondendo o teclado
 */
- (void)tocouView:(UIView *)sender {
  [self.usuario resignFirstResponder];
  [self.senha resignFirstResponder];
}
@end
