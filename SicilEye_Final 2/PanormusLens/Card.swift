//
//  SwiftUIView.swift
//  PanormusLens
//
//  Created by Samuele Lo Cascio on 05/07/24.
//

import SwiftUI

struct Card: View {
    var attraction: Attraction
    
    var body: some View{
        HStack {
            Image(attraction.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(20)
                .padding(.leading, 20)
                
               
                
               
                
            
                
            
            VStack(alignment: .leading) {
                Text(attraction.name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text("Distance: 35mt")
                    .font(.system(size: 14, weight: .light, design: .default))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
            
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.trailing, 20)
        }
        .frame(height: 100)
        .padding()
        .background(Color(hex: "#F5F5F5"))
        .cornerRadius(14)
    }
}

#Preview {
    Card(attraction: Attraction(id: 0, name: "Prova", x_cord: 2.32, y_cord: 2.32, storia: "Descrizione", arte: "Descrizione", curiosita: "Descrizione", image:""))
}
