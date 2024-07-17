//
//  ContentView.swift
//  PanormusLens
//
//  Created by Samuele Lo Cascio on 04/07/24.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var classificationResult: ClassificationResult
    
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}

struct ContentView: View {
    @State private var offset = CGSize.zero
    @State private var isCardExpanded = false
    
    @StateObject var classificationResult = ClassificationResult()
    
    let expandedPosition: CGFloat = 300
    let contractedPosition: CGFloat = 720
    
    var body: some View {
           NavigationView {
               ZStack {
                   CameraView(classificationResult: classificationResult)
                       .edgesIgnoringSafeArea(.all)
                       .navigationBarHidden(true) // Nascondi la barra di navigazione
                   
                   VStack {
                       Rectangle() // Barra orizzontale
                           .frame(width: 60, height: 6)
                           .cornerRadius(3)
                           .foregroundColor(.black)
                           .padding(.top, 10)
                       HStack {
                           Text("Places near you")
                               .font(.system(size: 30, weight: .bold, design: .default))
                               .padding()
                           Spacer()
                       }
                       
                       ScrollView {
                           VStack {
                               ForEach(attractions) { attraction in
                                   NavigationLink(destination: AttractionPage(attraction: attraction)) {
                                       Card(attraction: attraction)
                                   }
                               }
                           }
                           .padding(.bottom, 260)
                       }
                   }
                   .padding()
                   .background(Color.white)
                   .cornerRadius(14)
                   .offset(y: offset.height + (isCardExpanded ? expandedPosition : contractedPosition))
                   .gesture(
                       DragGesture()
                           .onChanged { gesture in
                               self.offset = gesture.translation
                           }
                           .onEnded { _ in
                               if self.offset.height < -50 {
                                   self.isCardExpanded = true
                               } else {
                                   self.isCardExpanded = false
                               }
                               self.offset = .zero
                           }
                   )
                   .animation(.interactiveSpring(), value: isCardExpanded)
               }
               .background(Color.gray)
               .edgesIgnoringSafeArea(.all)
           }
       }
   }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
