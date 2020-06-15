//
//  ContentView.swift
//  iDine
//
//  Created by Paul Mason on 6/13/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//
//initial piece of user interface

import SwiftUI
//Views are structs in swift
//all Views must conform to view protocol
//It needs a body that contains layout of
//view
//returns 'some View'
//Text used to represent strings
struct ContentView: View {
    //load in content of menu
    let menu = Bundle.main.decode([MenuSection].self,from: "menu.json")
    var body: some View {
        //add Navigation View
        //adds a navigation area at the top
        NavigationView {
            //want a list not one text
            List {
                //go over sections in menu
                ForEach(menu) {
                    //adds 'Breakfast' 'Drinks' etc
                    section in
                    //Add Section to separate the different sections
                    Section(header: Text(section.name)) {
                    //do another ForEach to pull the items in the sections
                        ForEach(section.items){
                            item in
                            //calls ItemRow.swift
                            ItemRow(item: item)
                        }
                    }
                }
            }
            //Add title to Navbar
            .navigationBarTitle("Menu")
            //Add a list style
            .listStyle(GroupedListStyle())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
