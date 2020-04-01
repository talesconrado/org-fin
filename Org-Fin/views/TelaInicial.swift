//
//  TelaInicial.swift
//  OrganizadorFinanceiro
//
//  Created by Tales Conrado on 11/03/20.
//  Copyright © 2020 Tales & Felipe. All rights reserved.
//

import Foundation

class TelaInicial{
    //Classe com funcoes de interacao inicial com o usuario
    let controlador:UsuarioController
    
    init(controlador:UsuarioController){
        //Define qual o controlador responsavel pelas interações
        self.controlador = controlador
    }
    
    func boasVindas(){
        //Apresenta texto de boas vindas e chama a função menu
        print("Seja bem-vindo ao seu Organizador Financeiro!\n")
        print("Uma aplicação que vai revolucionar a forma como você gerencia o seu dinheiro! Adicione gastos, confira seu saldo diário, acompanhe suas economias, tudo no seu T E R M I N A L.\n")
        print("Pressione enter para continuar...")
        _ = readLine()
        menu()
    }
    
    func menu(opcao: Int = 0){
        //Pode receber um parametro que caso não seja passado tem valor padrão 0 e serve para controlar o menu principal do programa. Na opção 0, ele printa o menu inteiro, na opção 1 ele entra no submenu de acessar um usuario cadastrado, na opção 2 podemos cadastrar um novo usuário, na opção 3 deletamos um usuário e na opção s, saímos do programa.

        
        let escolha:String?
        if(opcao == 0){
            print("Selecione uma das opções digitando seu número e pressionando enter.\n")
            print("1 - Entrar\n2 - Criar usuário\n3 - Gerenciar usuário\n\nS - Sair")
            escolha = readLine(strippingNewline: true)
        } else {
            escolha = String(opcao)
        }
        switch escolha?.lowercased(){
        case "1":
            print("Selecione um dos usuarios digitando o seu ID\n")
            mostrarUsuarios()
            if(controlador.usuarios.count == 0){
                print("Ainda não existem usuários cadastrados")
            }
            print("V - Voltar\n")
            let usuarioEscolhidoStr = readLine(strippingNewline: true)
            if(usuarioEscolhidoStr?.lowercased() == "v"){
                menu()
                return
            }
            if let usuarioEscolhido = usuarioEscolhidoStr, let escolha = Int(usuarioEscolhido), escolha <= controlador.usuarios.count - 1 && escolha >= 0{
                print("Usuário escolhido:", controlador.usuarios[escolha].nome)
                controlador.logarUsuario(index: escolha)
                let telaUsuario = TelaUsuario(id:escolha, telaInicialController:controlador)
                telaUsuario.mostrarDados()
            } else {
                print("\n\nValor inválido!")
                menu(opcao: 1)
                return
            }
            
            
        case "2":
            print("""
            Criando novo usuário... Deseja continuar?
            
            S - Sim

            V - Voltar

            """)
            let escolha = readLine(strippingNewline: true)
            
            if let escolhaAux = escolha{
                if escolhaAux.lowercased() == "v"{
                    menu()
                } else if escolhaAux.lowercased() == "s"{
                    var dados = receberDados()
                    while !dados.0{
                        dados = receberDados()
                    }
                    
                    let id = controlador.criarUsuario(nome: dados.1, salario: dados.2, gastoFixo: dados.3, valorGuardado: dados.4, valorEmergencial: dados.5)
                    controlador.logarUsuario(index: id)
                    let telaUsuario = TelaUsuario(id:id, telaInicialController:controlador)
                    telaUsuario.mostrarDados()
                }
            } else {
                print("\n\nEscolha inválida.")
                menu(opcao:2)
            }
        
            
        case "3":
            
            print("Selecione um dos usuarios para deletar digitando o seu ID")
            mostrarUsuarios()
            print("\n\nV - Voltar")
            let usuarioEscolhidoStr = readLine(strippingNewline: true)
            if let usuarioEscolhido = usuarioEscolhidoStr{
                if usuarioEscolhido.lowercased() == "v"{
                    menu()
                    return
                }
                if let escolha = Int(usuarioEscolhido), escolha <= controlador.usuarios.count - 1 && escolha >= 0{
                controlador.usuarios.remove(at: escolha)
                menu()
                } else {
                    print("\n\nEscolha inválida")
                    menu(opcao:3)
                    return
                }
            } else {
                print("\n\nEscolha inválida")
                menu(opcao:3)
                return
            }
        
        case "s":
            controlador.banco.salvarSessao(usuarios: controlador.usuarios)
            print("Obrigado, volte sempre! :)")
            
        default:
            print("\n\nEscolha inválida.")
            menu()
            return
        }
        
    }
    
    func mostrarUsuarios(){
        //Função que recebe os usuários do controlador e printa seus nomes.

        
        let listaUsuarios = controlador.listarUsuarios()
        var contador = 0
        for usuario in listaUsuarios{
            print(contador, usuario.nome)
            contador += 1
        }
    }
    
    func receberDados()-> (Bool, String, Double, Double, Double, Double){
        //função para receber os dados do cadastro de novo usuário que devolve uma tupla com os dados.
        
        print("Precisamos de algumas informações suas para começar.\n")
        print("Primeiro, digite o seu nome:")
        let nomeString = readLine(strippingNewline: true)
        
        guard let nome = nomeString, nome != "" else{
            print("Nome inválido.\n\n\n")
            return (false, "", 0.0, 0.0, 0.0, 0.0)
        }
        
        print("Agora digite o seu salario:")
        let salarioString = readLine(strippingNewline: true)
        
        guard let salario = salarioString, let salarioDouble = Double(salario), salarioDouble > 0
            else{
                print("Salario inválido.\n\n\n")
                return (false, "", 0.0, 0.0, 0.0, 0.0)
        }
        
        print("Digite qual o seu gasto fixo:")
        let gastoString = readLine(strippingNewline: true)
        
        guard let gasto = gastoString, let gastoDouble = Double(gasto), gastoDouble >= 0 else {
                print("Gasto inválido.\n\n\n")
                return (false, "", 0.0, 0.0, 0.0, 0.0)
        }
        
        print("Digite qual valor a ser guardado:")
        let valorGuardadoString = readLine(strippingNewline: true)
        
        guard let valorGuardado = valorGuardadoString, let valorGuardadoDouble = Double(valorGuardado), valorGuardadoDouble >= 0 else {
                print("Valor a ser guardado inválido.\n\n\n")
                return (false, "", 0.0, 0.0, 0.0, 0.0)
        }
        
        print("Digite qual valor você quer deixar como emergencial:")
        let valorEmergencialString = readLine(strippingNewline: true)
        
        guard let valorEmergencial = valorEmergencialString, let valorEmergencialDouble = Double(valorEmergencial), valorEmergencialDouble >= 0 else {
            print("Valor emergencial inválido.\n\n\n")
            return (false, "", 0.0, 0.0, 0.0, 0.0)
        }
        
        return (true, nome, salarioDouble, gastoDouble, valorGuardadoDouble, valorEmergencialDouble)
        
        }
    
}
