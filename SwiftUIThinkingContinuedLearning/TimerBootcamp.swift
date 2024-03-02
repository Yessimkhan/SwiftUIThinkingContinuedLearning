//
//  TimerBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 02.03.2024.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    //Current time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    //Coundown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
     */
    
    //Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .second, value: 5, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(minute) minutes, \(second) seconds"
    }
     */
    
    //Animation Counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.purple, .indigo],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundStyle(Color.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
//            HStack (spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundStyle(.white)
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.yellow)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.brown)
                    .tag(5)
            }
            .cornerRadius(10)
            .frame(width: 300, height: 200)
            .tabViewStyle(.page)
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        })
        
        
    }
}

#Preview {
    TimerBootcamp()
}
