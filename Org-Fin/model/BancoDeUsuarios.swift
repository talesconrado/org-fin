//
//  BancoDeUsuario.swift
//  OrganizadorFinanceiro
//
//  Created by Tales Conrado on 31/03/20.
//  Copyright © 2020 Tales & Felipe. All rights reserved.
//

import Foundation

//Aqui definimos o caminho onde ficarão salvos os dados
let home = FileManager.default.homeDirectoryForCurrentUser
let arquivo:String = "Documents/banco_de_usuarios.txt"
let arquivoURL = home.appendingPathComponent(arquivo)

class BancoDeUsuarios:Codable{
    //O banco é composto por um array de Usuários.
    var usuarios = [Usuario]()
    
    init(){
        //Ao inicializar a classe, verificamos a existência do arquivo pelo path dado, decodificamos os usuarios no arquivo do path caso a verificação seja verdadeira.

        if (FileManager.default.fileExists(atPath: arquivoURL.path)){
            do {
                let arquivoASerLido = try Data(contentsOf: arquivoURL)
                usuarios = try JSONDecoder().decode([Usuario].self, from: arquivoASerLido)
            } catch {
                print(error.localizedDescription)
            }
        //Caso o arquivo no path dado não seja encontrado, criamos um arquivo nesse path.
        } else {
            do {
                let jsonData = try JSONEncoder().encode(usuarios)
                try jsonData.write(to: arquivoURL)
            } catch {
                print("Impossível escrever no arquivo.")
            }
        }
    }
    
    func salvarSessao(usuarios:[Usuario]){
        //função que encoda os dados da array de usuarios e escreve no arquivo no path dado.
        do {
            let jsonData = try JSONEncoder().encode(usuarios)
            try jsonData.write(to: arquivoURL)
        } catch {
            print("Impossível escrever no arquivo.")
        }
    }
    
}
