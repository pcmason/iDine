//
//  CheckoutView.swift
//  iDine
//
//  Created by Paul Mason on 6/13/20.
//  Copyright © 2020 Paul Mason. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    //global env object of order
    @EnvironmentObject var order: Order
    @EnvironmentObject var favorite: Favorite
    //add multiple payment options
    static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    //add State which works like an EnvironmentObject, just for simple variables like integers and strings
    //marked private as not designated for private access
    @State private var paymentType = 0
    //create var to let user choose a time for them to recieve their order
    static let pickupTimes = ["Now", "Tonight","Tomorrow Morning"]
    //mark pickupTime as 0, and private
    @State private var pickupTime = 0
    //one variable lets users select if they have loyalty points
    @State private var addLoyaltyDetails = false
    //add var that lets user enter card number if they do have points
    @State private var loyaltyNumber = ""
    //add variable for possible tip options
    static let tipAmounts = [10, 15, 20, 25, 0]
    //add to store selected segment
    @State private var tipAmount = 1
    //add totalPrice variable
    var totalPrice: Double {
        let total = Double(order.total)
        //calculate how much tip adds
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    //variable that shows if order has went through or not
    @State private var showingPaymentAlert = false
    var body: some View {
        //Form makes the new view a page where you select your payment type
        Form{
            Section{
                //add option to gain loyalty points
                //animation adds an animatoin when it changes
                Toggle(isOn: $addLoyaltyDetails.animation()){
                    //text appears as description
                    Text("Add iDine loyalty card")
                }
                //can just ender card number if you already have one
                //adds placeholder text too
                //wrap around if statement so it shows up if you have the loyalty card
                if addLoyaltyDetails{
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
                //picker uses paymentType for its selection
                //has lable that is not visible yet but will change in a moment
                //loops over all payment types and adds them as options
                Picker("How do you want to pay?", selection: $paymentType){
                    ForEach(0 ..< Self.paymentTypes.count){
                        Text(Self.paymentTypes[$0])
                    }
                .padding()
                }
            }
            //add section for tips
            //has header that acts as title
            Section(header: Text("Add a tip?")){
                Picker("Percentage:", selection: $tipAmount){
                    ForEach(0 ..< Self.tipAmounts.count){
                        Text("\(Self.tipAmounts[$0])%")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
            }
            //add section that lets you choose the pickup time
            Section(header: Text("When would you like to pickup?")){
                Picker("Time:", selection: $pickupTime){
                    ForEach(0 ..< Self.pickupTimes.count){
                        Text(Self.pickupTimes[$0])
                    }
                .padding()
                }
            }
            //add final section to place order and see total
            //specifier sets decimal digit limit
            Section(header: Text("TOTAL: $\(totalPrice,specifier: "%.2f")")
                //add larger font
                .font(.largeTitle)
                )
            {
                Button("Confirm Order"){
                    //confirm order here
                    self.showingPaymentAlert.toggle()
                }
            }
        }
        //add navbar title with Payment insmall text rather than large text
            .navigationBarTitle(Text("Payment"), displayMode: .inline)
            //shows alert when showingPaymentAlert is true
            .alert(isPresented: $showingPaymentAlert){
                //add alert and the contents of said alert
                Alert(title: Text("Order Confirmed!"), message: Text("Your total was $\(totalPrice, specifier: "%.2f")-Thank you !"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    //ensure preview workds
    static let favorite = Favorite()
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(favorite).environmentObject(order)
    }
}
