//
//  DragGestureBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 26.12.2023.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack{
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 300, height: 500)
                .offset(offset)
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .scaleEffect(getScaleAmount())
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                offset = value.translation
                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                offset = .zero
                            }
                        }
            )
        }
    }
    
    func getScaleAmount() -> CGFloat{
        
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount() -> Double {
        
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        
        let percentageAsDouble = Double(percentage) 
        let maxAngle: Double = 10
        
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureBootcamp()
}
