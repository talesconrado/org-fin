//
//  BancoDeUsuario.swift
//  OrganizadorFinanceiro
//
//  Created by Tales Conrado on 31/03/20.
//  Copyright © 2020 Tales & Felipe. All rights reserved.
//

import Foundation

let home = FileManager.default.homeDirectoryForCurrentUser
let arquivo:String = "Documents/arquivo.txt"
let arquivoURL = home.appendingPathComponent(arquivo)

class BancoDeUsuarios:Codable{
    var usuarios = [Usuario]()
    init(){
        if (FileManager.default.fileExists(atPath: arquivoURL.path)){
            do {
                let arquivoASerLido = try Data(contentsOf: arquivoURL)
                usuarios = try JSONDecoder().decode([Usuario].self, from: arquivoASerLido)
            } catch {
                print(error.localizedDescription)
            }
                    
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
        do {
            let jsonData = try JSONEncoder().encode(usuarios)
            try jsonData.write(to: arquivoURL)
        } catch {
            print("Impossível escrever no arquivo.")
        }
    }
    
}
