//
//  UsuarioController.swift
//  OrganizadorFinanceiro
//
//  Created by Tales Conrado on 11/03/20.
//  Copyright © 2020 Tales & Felipe. All rights reserved.
//

import Foundation


class UsuarioController{
    //Controller para atualizar e interagir com o model Usuario
    //Possui uma array de usuarios para guardar os dados
    //Possui um banco de usuarios para salvar e carregar os dados
    var banco = BancoDeUsuarios()
    var usuarios:[Usuario]
    var usuarioAtual:Int = -1
    
    init(){
        //inicializa o banco de usuarios
        usuarios = banco.usuarios
    }
    
    func criarUsuario(nome:String, salario:Double, gastoFixo:Double, valorGuardado:Double, valorEmergencial:Double)->Int{
        //Funcao para criar um novo usuario e atualiza quem eh o usuario atual
        let usuario = Usuario(nome:nome, salario:salario, gastoFixo: gastoFixo, valorGuardado: valorGuardado, valorEmergencial: valorEmergencial)
        
        usuarios.append(usuario)
        
        usuarioAtual = usuarios.count - 1
        usuarios[usuarioAtual].valorDisponivelDiario = usuarios[usuarioAtual].calculaDisponivelDiario()
        return usuarioAtual
    }

    
    
    func logarUsuario(index:Int){
        //Atualiza o index do usuario atual de acordo com um input na view
        usuarioAtual = index
    }
    
    
    func listarUsuarios() -> [Usuario]{
        //Retorna o array de usuarios
        return usuarios
        
    }
    
    func atualizaValorGastoMensal(gasto:Double){
        //Adiciona um novo gasto
        usuarios[usuarioAtual].valorGastoMensal += gasto
    }
    
}
