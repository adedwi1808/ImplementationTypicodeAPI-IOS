//
//  CommentData.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 05/01/22.
//

import Foundation

struct CommentData:Decodable {
    let postId : Int
    let name : String
    let body : String
}
