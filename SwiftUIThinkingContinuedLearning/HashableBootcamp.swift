//
//  HashableBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 06.01.2024.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    let subTitle: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subTitle)
    }
}

struct HashableBootcamp: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE", subTitle: "FIRST"),
        MyCustomModel(title: "TWO", subTitle: "SECOND"),
        MyCustomModel(title: "THREE", subTitle: "THIRD"),
        MyCustomModel(title: "FOUR", subTitle: "FOURTH"),
        MyCustomModel(title: "FIVE", subTitle: "FIFTH"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
