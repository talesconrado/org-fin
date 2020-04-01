//
//  TelaUsuario.swift
//  OrganizadorFinanceiro
//
//  Created by Tales Conrado on 11/03/20.
//  Copyright © 2020 Tales & Felipe. All rights reserved.
//

import Foundation

class TelaUsuario{
    //Definimos os atributos da tela de usuario

    var idUsuario:Int
    let controlador:UsuarioController
    let nome:String
    let gastos:Double
    let salario:Double
    var diario:Double
    
    init(id:Int, telaInicialController:UsuarioController){
        //recebe um id e um controlador
        //atribui valores vindos do controlador para o usuario

        idUsuario = id
        controlador = telaInicialController
        nome = controlador.usuarios[idUsuario].nome
        gastos = controlador.usuarios[idUsuario].valorGastoMensal
        salario = controlador.usuarios[idUsuario].salario
        diario = controlador.usuarios[idUsuario].valorDisponivelDiario
    }
    
    func mostrarDados(){
        //mostra o nome do usuario e o seu valor diário disponível

        print("\n\n\nUsuário:", nome)
        print("")
        print("Valor disponivel diário: R$", Double(round(diario*100)/100))
        print("\n")
        opcoesUsuario()
    }
    
    func opcoesUsuario(){
        //mostra um menu para adicionar novo gasto, passar um dia e voltar para o menu principal

        print("1 - Adicionar um novo gasto.\n2 - Passar um dia.\n3 - Mostrar distribuição da sua renda.\n\n\nV - Voltar.")
        let escolha = readLine(strippingNewline: true)
        
        if let escolhaAux = escolha{
            switch escolhaAux.lowercased(){
            case "v":
                let telaInicial = TelaInicial(controlador:controlador)
                telaInicial.menu()
            case "1":
                adicionarGasto()
            case "2":
                passarDia()
            case "3":
                mostrarDistribuicao()
            default:
                print("\n\nEscolha inválida. Tente novamente.")
                mostrarDados()
            }
        } else {
            print("\n\nEscolha inválida. Tente novamente.")
            mostrarDados()
        }
    }
    
    func adicionarGasto(){
        //função para adicionar um novo gasto

        print("Digite o seu gasto, separando os decimais por ponto (.) e em seguida pressione enter.\n")
        let novoGasto = readLine(strippingNewline: true)
        if let gasto = novoGasto, let gastoDouble = Double(gasto), gastoDouble > 0{
            diario -= gastoDouble
            controlador.usuarios[idUsuario].valorDisponivelDiario -= gastoDouble
        }
        mostrarDados()
    }
    
    func passarDia(){
        //função para passar o dia e fazer o balanceamento financeiro do novo dia
        diario = diario + controlador.usuarios[idUsuario].valorDiarioInicial
        controlador.usuarios[idUsuario].valorDisponivelDiario += controlador.usuarios[idUsuario].valorDiarioInicial
        mostrarDados()
    }
    
    func mostrarDistribuicao(){
        //Mostra os gastos fixos, valor guardado e valor emergencial que o usuario cadastrou
        print("""
            DISTRIBUIÇÃO DE RENDA 🦁
            =========================
            Gasto fixo: \(controlador.usuarios[idUsuario].gastoFixo)
            Valor guardado: \(controlador.usuarios[idUsuario].valorGuardado)
            Valor emergencial: \(controlador.usuarios[idUsuario].valorEmergencial)
        """)
        mostrarDados()
    }
    
}
