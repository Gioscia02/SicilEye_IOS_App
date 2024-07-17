//
//  AttractionPage.swift
//  PanormusLens
//
//  Created by Samuele Lo Cascio on 05/07/24.
//

import Foundation
import SwiftUI
import MapKit

extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.index(after: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct AttractionPage: View{
    var attraction: Attraction
    
    var body: some View {
        ZStack {
            
            VStack {
                Image(attraction.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 400)
                    .clipped()
                    .offset(CGSize(width: 0.0, height: -50.0))
                    .ignoresSafeArea()
            
                Spacer() // slc: in caso si sostituisce con un Color.white per levare lo spazio grigio sotto
                
            }
        
            
            
            
            VStack {
                Spacer(minLength: 180)
                
                VStack {
                    
                    
                    HStack {
                        Text(attraction.name)
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .padding()
                        Spacer()
                    }
                    
                    Button(action: {
                        
                        openInMaps(for: attraction)
                                              
                    }) {
                        Text("Take me there")
                            .font(.system(size: 26, weight: .bold, design: .default))
                        
                            .foregroundColor(.white)
                        
                        
                        
                    }
                    .padding(.horizontal, 70)
                    .padding(.vertical, 20)
                    .background(Color(hex: "#00B3FF"))
                    .cornerRadius(22)
                    
                    
                    ScrollView {
                        Text("History:")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .multilineTextAlignment(.leading)
                        Text(attraction.storia)
                            .font(.system(size: 23, weight: .light, design: .default))
                            .multilineTextAlignment(.leading)
                        Text("Art and Culture:")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .multilineTextAlignment(.leading)
                        Text(attraction.arte)
                            .font(.system(size: 23, weight: .light, design: .default))
                            .multilineTextAlignment(.leading)
                        Text("Curiosities:")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .multilineTextAlignment(.leading)
                        Text(attraction.curiosita)
                            .font(.system(size: 23, weight: .light, design: .default))
                            .multilineTextAlignment(.leading)
                        
                            
                    }
                    .padding()
                    
                    
                }
                
                .padding()
                .background(.white)
                .cornerRadius(35)
                .ignoresSafeArea()
                
            }
            
    
        }
        .background(.gray)
    }
}

func openInMaps(for attraction: Attraction) {
    let coordinate = CLLocationCoordinate2D(latitude: attraction.x_cord, longitude: attraction.y_cord)
    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = attraction.name
    
    // Opzionalmente, puoi specificare altre opzioni come modalità di trasporto, etc.
    // mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    
    mapItem.openInMaps(launchOptions: nil)
}

#Preview {
    AttractionPage(attraction: attractions[0])
}
