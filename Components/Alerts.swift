//
//  File.swift
//  
//
//  Created by Maria Luiza Amaral on 22/04/22.
//

import SwiftUI
struct AlertLandscape: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight  = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack{
            ZStack{
                Color.white
                 .ignoresSafeArea()
                 .opacity(0.7)
                
                Rectangle()
                    .fill(Color("creme"))
                    .frame(width: screenWidth - 400, height: screenHeight - 400)
                Text("Portrait mode required, please rotate the iew")
                    .font(.custom("Poppins-Regular", size: 36))
                    .foregroundColor(Color("brown"))
            }
        }
    }
    
}

struct AlertMoveIpad: View {
    
    var body: some View {
        VStack{
            Image("alertMoveIpad")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 329, height: 137)
                    
                
        }
    }
    
}

struct AlertBlushScene: View {
    
    var body: some View {
        VStack{
            Image("blushScene")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 352, height: 137)
                    
                
        }
    }
    
}

struct AlertDrag: View {

    var body: some View {
        VStack{
            Image("drag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 352, height: 137)
                    
                
        }
    }
    
}
