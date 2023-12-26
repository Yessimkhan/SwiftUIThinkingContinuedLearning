//
//  DragGestureBootcamp2.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 26.12.2023.
//

import SwiftUI

struct DragGestureBootcamp2: View {
    
    @State var OffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    var body: some View {
        ZStack{
            Color(Color.green).ignoresSafeArea()
            
            BottomView()
                .offset(y: OffsetY) // 底部初始位置
                .offset(y: currentDragOffsetY) // 拖拉位置
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height // y軸的 拖拉量
                            }
                        }
                        .onEnded{ value in

                            withAnimation(.spring()){
                                // y 被拉超過 150  執行
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -OffsetY // 剛好跟初始位置 相對

                                }
                                // endingOffsetY != 0 -> 不等於 0 代表BottomView被拉開

                                else if endingOffsetY != 0 && currentDragOffsetY > 150{
                                    endingOffsetY = 0
                                }
                                
                                currentDragOffsetY = 0 // 結束完一個動作 都將Y軸變化量歸 0
                            }
                        }
                )
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct BottomView: View {
    var body: some View {
        VStack(spacing: 20){
            Image(systemName: "chevron.up")
                .foregroundColor(.black)
                .padding()
            
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description of our app. This is my favorite SwiftUI course and I recommend to all of my freinds to subscribe to Swiftful Thinking")
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Text("create an account".uppercased())
                .foregroundColor(Color.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(15))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}

#Preview {
    DragGestureBootcamp2()
}
