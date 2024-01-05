//
//  HapticsBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 05.01.2024.
//

import SwiftUI

class HapticsManager {
    static let instance = HapticsManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack {
            Button("success"){ HapticsManager.instance.notification(type:.success) }
            Button("warning"){ HapticsManager.instance.notification(type:.warning) }
            Button("error"){ HapticsManager.instance.notification(type:.error) }
            Divider()
            Button("heavy"){ HapticsManager.instance.impact(style: .heavy) }
            Button("light"){ HapticsManager.instance.impact(style: .light) }
            Button("medium"){ HapticsManager.instance.impact(style: .medium) }
            Button("rigid"){ HapticsManager.instance.impact(style: .rigid) }
            Button("soft"){ HapticsManager.instance.impact(style: .soft) }
        }
    }
}

#Preview {
    HapticsBootcamp()
}
