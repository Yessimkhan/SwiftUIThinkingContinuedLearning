//
//  EscapingBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 30.01.2024.
//

import SwiftUI

class EscapingBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
//        let newData = downloadData()
//        text = newData
        
//        downloadData3 {[weak self] data in
//            self?.text = data
//        }
        
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        return "New Data!!!"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("New Data!!!")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data!!!")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let results = DownloadResult(data: "New Data!!!")
            completionHandler(results)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let results = DownloadResult(data: "New Data!!!")
            completionHandler(results)
        }
    }
    
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject var vm  = EscapingBootcampViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(Color.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}
