//
//  ScrollViewReaderBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 27.12.2023.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .padding(.horizontal)
                .border(Color.black)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("GO TO # \(textFieldText)"){
                withAnimation(.spring()){
                    if let index = Int(textFieldText){
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView(.horizontal){
                ScrollViewReader{ proxy in
                    
                    HStack {
                        ForEach(0..<50 ,id: \.self){ index in
                            Text("This is item # \(index)")
                                .font(.headline)
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                                .padding()
                                .id(index)
                            
                        }
                        .onChange(of: scrollToIndex) { value in
                            withAnimation(.spring()){
                                proxy.scrollTo(value, anchor: .top)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
