//
//  PhotoData.swift
//  KumparanTech-Test
//
//  Created by Ade Dwi Prayitno on 05/01/22.
//

import Foundation

struct PhotoData: Decodable {
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
