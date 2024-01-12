//
//  ArraysBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 07.01.2024.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray(){
        // Sort
        /*
        filteredArray = dataArray.sorted(by: { user1, user2 in
            return user1.points > user2.points
        })
        
//        filteredArray = dataArray.sorted(by: {$0.points > $1.points})
         */
        
        // Filter
        /*
//        filteredArray = dataArray.filter({ user in
//            user.points > 50
//        })
        
        filteredArray = dataArray.filter({$0.isVerified})
         */
        
        // Map
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            user.name
//        })
        
//        mappedArray = dataArray.map({$0.name ?? "Error".uppercased()})
        
//         ignore errors
//        mappedArray = dataArray.compactMap({ user in
//            user.name
//        })
        
        mappedArray = dataArray.compactMap({$0.name})
         */
        
        mappedArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({$0.isVerified})
            .compactMap({$0.name})
        
    }
    
    func getUsers(){
        let user1 = UserModel(name: "Yesso", points: 100, isVerified: true)
        let user2 = UserModel(name: "Maga", points: 90, isVerified: false)
        let user3 = UserModel(name: nil, points: 45, isVerified: true)
        let user4 = UserModel(name: "Aza", points: 86, isVerified: false)
        let user5 = UserModel(name: "Uisip", points: 94, isVerified: true)
        let user6 = UserModel(name: "Alzhan", points: 57, isVerified: false)
        let user7 = UserModel(name: "Maksh", points: 12, isVerified: true)
        let user8 = UserModel(name: nil, points: 45, isVerified: false)
        let user9 = UserModel(name: "Bala", points: 90, isVerified: true)
        let user10 = UserModel(name: "Ace", points: 34, isVerified: false)
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack {
//                        Text(user.name)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}
