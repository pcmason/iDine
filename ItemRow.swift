//
//  ItemRow.swift
//  iDine
//
//  Created by Paul Mason on 6/13/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI

struct ItemRow : View {
    //add colors to differentiate vegan food from food with nuts, etc
    static let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    //add MenuItem to be used in view
    var item: MenuItem
    var body: some View {
        //wrap with NavigationLink that is a link to a description page for each item
        //Connects to ItemDetail.swift
        NavigationLink(destination: ItemDetail(item: item)) {
            //create Hstack which places
            //child views side-to-side
            HStack{
                //item's image
                //add clipshape to change all images to fit into a circle
                //add overlay to give the circle a gray border
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                //Add a Vstack
                //change alignment from center to leading
                VStack(alignment: .leading){
                    //name of item
                    //add font to make it standout
                    Text(item.name)
                        .font(.headline)
                    //Add item's price
                    Text("$\(item.price)")
                }
                //Spacer function used to push restrictions towards the right
                Spacer()
                //loop over all restrictions and put each one into a text view
                //also string is ID for each item
                ForEach(item.restrictions, id: \.self){
                    restriction in
                        Text(restriction)
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(5)
                            .background(Self.colors[restriction, default: .black])
                            .clipShape(Circle())
                            .foregroundColor(.white)
                }
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        //needs item argument
        ItemRow(item: MenuItem.example)
    }
}
