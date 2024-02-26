//
//  DownloadWithCombine.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 23.02.2024.
//

import SwiftUI
import Combine

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancelables = Set<AnyCancellable>()
    
    init() {
        getPost()
    }
    
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchSerialQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancelables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let responce = output.response as? HTTPURLResponse,
            responce.statusCode >= 200 && responce.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}


struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity , alignment: .leading)
            }
        }
    }
}

#Preview {
    DownloadWithCombine()
}
