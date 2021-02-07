//
//  Datamodel.swift
//  dataModelSepeda
//
//  Created by muhammad luthfi farizqi on 02/02/21.
//

import Foundation
import Combine


struct DataModel : Identifiable {
    let id: Int
    let namaProduk: String
    let fotoProduk: String
    let hargaProduk: Int
    let lokasi: String
    let ratingCount: Int
    let jumlahRating: Int
    
    init(id:Int, namaProduk: String, fotoProduk: String, hargaProduk: Int, lokasi:String, ratingCount: Int, jumlahRating: Int) {
        self.id = id
        self.namaProduk = namaProduk
        self.fotoProduk = fotoProduk
        self.hargaProduk = hargaProduk
        self.lokasi  = lokasi
        self.ratingCount = ratingCount
        self.jumlahRating = jumlahRating
    }
    
}

