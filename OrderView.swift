//
//  OrderView.swift
//  iDine
//
//  Created by Paul Mason on 6/13/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    //give global env variable order
    @EnvironmentObject var order: Order
    //create a function for deleting items
    func deleteItems(at offsets: IndexSet){
        order.items.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationView {
            //add a list gives scrolling table
            List {
                //section splits up information
                Section {
                    //ForEach and HStack show array of order items displaying name and price
                    ForEach(order.items){
                        item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }//add onDelete method
                        .onDelete(perform: deleteItems)
                    
                }
                //another section showing a navigation link to place the order
                Section {
                    NavigationLink(destination: CheckoutView()){
                        Text("Place Order")
                    }.font(.subheadline)
                    
                }//ensure you cannot place an order if you have no items in the cart
                    .disabled(order.items.isEmpty)
            }
            //add navbar title
            .navigationBarTitle("Order")
            //Grouped styling for table
            .listStyle(GroupedListStyle())
            //add this so users can remove several items at a time
                .navigationBarItems(trailing: EditButton())
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    //makes the preview work
    static let order = Order()
    static let favorite = Favorite()
    static var previews: some View {
        AppView().environmentObject(order).environmentObject(favorite)
    }
}
