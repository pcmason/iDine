//
//  ItemDetail.swift
//  iDine
//
//  Created by Paul Mason on 6/13/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI
//this is the description page when you click on an item in the app this is where it will take you
struct ItemDetail: View {
    //add global order variable from env
    @EnvironmentObject var order: Order
    //add global favorite variable from env
    @EnvironmentObject var favorite: Favorite
    //declare item from nodejs
    var item: MenuItem
    var body: some View {
        VStack {
            //use a ZStack to handle overlapping view
            ZStack(alignment: .bottomTrailing) {
                //item's image
                Image(item.mainImage)
                //add text that gives credit to whoever took the photo in the bottom right of the photo
                Text("Photo: \(item.photoCredit)")
                //help make text more visible
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    //offset moves the credit slightly up
                    .offset(x: -5, y: -5)
            }
            //item's description
            //add padding to make description look better
            Text(item.description)
                .padding()
            //Add button that adds item to a cart
            Button("Order Now") {
                self.order.add(item: self.item)
            }.font(.headline)
                .background(Color.yellow)
                .foregroundColor(Color.red)
            Button("Add to Favorites"){
                self.favorite.add(item: self.item)
            }.font(.headline)
                .background(Color.red)
                .foregroundColor(Color.yellow)
            //this Spacer() puts the content to the top of the page
            Spacer()
        }
        //navigation bars title is the items name
            .navigationBarTitle(Text(item.name), displayMode: .inline)
    }
}

//struct ItemDetailOrd_Previews: PreviewProvider {
//    //helps make the preview code work
//    static let order = Order ()
//    //static let favorite = Favorite()
//    static var previews: some View {
//        NavigationView{
//            ItemDetail(item: MenuItem.example).environmentObject(order)
//        }
//    }
//}
struct ItemDetailFav_Previews:
PreviewProvider{
    static let favorite = Favorite()
    static let order = Order ()
    static var previews: some View {
            ItemDetail(item: MenuItem.example).environmentObject(favorite).environmentObject(order)
    }
}
