//
//  main.swift
//  OrganizadorFinanceiro
//
//  Created by Tales Conrado on 10/03/20.
//  Copyright © 2020 Tales & Felipe. All rights reserved.
//

import Foundation

class Main{

    let controlador:UsuarioController
    let telaInicial:TelaInicial
    var keepRunning = true
    init(){
        controlador = UsuarioController()
        telaInicial = TelaInicial(controlador:controlador)
        telaInicial.boasVindas()
    }

}

let fluxo = Main()
