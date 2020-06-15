//
//  Favorite.swift
//  iDine
//
//  Created by Paul Mason on 6/14/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI

class Favorite: ObservableObject {
    //add published var for items
    @Published var items = [MenuItem]()
    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }
    func add(item: MenuItem){
        items.append(item)
    }
    func removeFav(item: MenuItem){
        if let index =
            items.firstIndex(of: item){
            items.remove(at: index)
        }
    }
}

