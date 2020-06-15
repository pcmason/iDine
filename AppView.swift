//
//  AppVie.swift
//  iDine
//
//  Created by Paul Mason on 6/13/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI

struct AppView: View {
    //add global order variable from env
    @EnvironmentObject var order: Order
    //add Global favorite var from env
    @EnvironmentObject var favorite: Favorite
    var body: some View {
        //TabView creates tabs
        TabView{
            //creates instance of ContentView and and assigns an image and text as its tab item label
            ContentView()
                //needed to add images and text
                .tabItem{
                    //systemName allows us to load images from an icon set
                    Image(systemName: "list.dash")
                    Text("Menu")
            }
            OrderView()
                .tabItem{
                    Image(systemName:
                    "square.and.pencil")
                    Text("Order")
            }
            FavoriteView()
                .tabItem{
                    Image(systemName: "star")
                    Text("Favorites")
            }
        }
    }
}

struct OrderViewApp_Previews: PreviewProvider {
    //added so preview can work
    static let order = Order()
    static let favorite = Favorite()
    
    static var previews: some View {
        AppView().environmentObject(order).environmentObject(favorite)
    }
}

//struct FavoriteViewApp_Previews: PreviewProvider{
//    static let favorite = Favorite()
//     
//    static var previews: some View {
//        AppView().environmentObject(favorite)
//    }
//}
