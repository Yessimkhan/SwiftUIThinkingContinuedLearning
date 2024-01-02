//
//  MultiplySheetsBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 27.12.2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 - Use a binding
// 2 - Use a multiply .sheet
// 2 - Use a $item
struct MultiplySheetsBootcamp: View {

    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<50){ index in
                    Button("Buttton \(index)") {
                        selectedModel = RandomModel(title: "\(index) page")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
    }
        
}

struct NextScreen: View {
    // 1 - Using a @Binding
    // @Binding var selectedModel: RandomModel
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultiplySheetsBootcamp()
}
