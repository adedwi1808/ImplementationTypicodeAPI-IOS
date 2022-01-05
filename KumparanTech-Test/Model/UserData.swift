//
//  UserData.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 04/01/22.
//

import Foundation

struct UserData: Codable {
    let id : Int
    let name: String
    let email: String
    let address: Address
    let company: Company
}

struct Company: Codable {
    let name : String
}

struct Address: Codable {
    let street : String
    let suite  : String
    let city   : String
    let zipcode: String
}
