//
//  ContentView.swift
//  Dice Task
//
//  Created by Ilmari Lehmusjärvi on 21.2.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State public var dieValue1 : Int
    @State public var dieValue2 : Int
    
    @State public var dieFace1: String = "Dice3"
    @State public var dieFace2: String = "Dice4"
    
    var body: some View {
        
        ZStack{
            Image("DiceTableBackground")
                .resizable()
                .edgesIgnoringSafeArea([.top, .bottom])
            
            VStack(alignment: .center) {
                Image("DiceTableLogo")
                    .padding(100)
                
                HStack{
                    Image(dieFace1)
                    Image(dieFace2)
                    
                }
                Text("You rolled:" + " " + String(dieValue1 + dieValue2))
                    .font(.system(size: 30.0))
                    .padding(.bottom , 80)
                Button(action: randomdie) {
                    Text("Roll Dice")
                        .font(.system(size: 48.0))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(15)
                        .background(RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.orange))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 4))

                    
                }
            }
        }
    }
    
    private func randomdie(){
        dieValue1 = Int.random(in: 1..<7)
        dieValue2 = Int.random(in: 1..<7)
        
        dieFace1 = "Dice" + String(dieValue1)
        dieFace2 = "Dice" + String(dieValue2)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dieValue1:3, dieValue2:4 )
    }
}
