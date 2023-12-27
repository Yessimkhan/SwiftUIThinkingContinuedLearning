//
//  GeometryReaderBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 27.12.2023.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    func getPercentage(geo: GeometryProxy) -> Double{
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    
    
    var body: some View {
        
        VStack {
          
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack{
                    ForEach(0..<20) { index in
                        GeometryReader{ geometry in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20.0)
                                    .rotation3DEffect(
                                        Angle(degrees: getPercentage(geo: geometry) * 40),
                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                                        
                                )
                            }
                        }
                        .frame(width: 350, height: 250)
                        .padding()
                    }
                }
            })
        }
        
//        GeometryReader{ geometry in
//            HStack(spacing: 0){
//                Rectangle()
//                    .fill(Color.yellow)
//                    .frame(width: geometry.size.width * 0.666)
//                Rectangle()
//                    .fill(Color.green)
//            }
//            .ignoresSafeArea()
//        }
    }
}

#Preview {
    GeometryReaderBootcamp()
}
