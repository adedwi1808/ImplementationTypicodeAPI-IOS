//
//  Post.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 04/01/22.
//

import Foundation

struct Post: Decodable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
