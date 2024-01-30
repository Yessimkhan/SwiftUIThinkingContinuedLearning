//
//  TypealiasBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 30.01.2024.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let rating: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    @State var item: MovieModel = MovieModel(title: "Rush Hour", director: "Jackie Chan", rating: 10)
    @State var item1: TVModel = TVModel(title: "Bir Bolaik", director: "Dana", rating: 9)
    
    var body: some View {
        VStack(spacing: 10) {
            Text(item.title)
            Text(item.director)
            Text("\(item.rating)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}
