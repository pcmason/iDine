//
//  FavoriteView.swift
//  iDine
//
//  Created by Paul Mason on 6/14/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    //set global env variables
    @EnvironmentObject var favorite:Favorite
    @EnvironmentObject var order: Order
    //add colors to differentiate vegan food from food with nuts, etc
    static let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    //function to delete items from favorite
    func deleteItems(at offsets: IndexSet){
        favorite.items.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationView {
            List {
                Section{
                    ForEach(favorite.items){
                    item in
                    //calls ItemRow.swift
                    ItemRow(item: item)
                                
                    }.onDelete(perform: deleteItems)
                            
                        
                    }
                    
                }.navigationBarTitle("Favorites")
                        .listStyle(GroupedListStyle())
                .navigationBarItems(trailing: EditButton())
                
            }
        }
    }


struct FavoriteView_Previews: PreviewProvider {
    static let favorite = Favorite()
    static let order = Order()
    static var previews: some View {
        AppView().environmentObject(favorite).environmentObject(order)
    }
}




