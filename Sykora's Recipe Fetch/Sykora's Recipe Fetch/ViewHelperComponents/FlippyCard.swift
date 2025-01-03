//  FlippyCard.swift
//  Sykora's Recipe Fetch

import SwiftUI

struct FlippyCard<Front, Back>: View where Front: View, Back: View {
    @Environment(\.colorScheme) var colorScheme
    var front: () -> Front
    var back: () -> Back
    
    @State var isFlipped: Bool = false
    @State var cardRotation = 0.0
    @State var contentRotation = 0.0
    let cardHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 400 : 180
    
    init(@ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            if isFlipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .frame(height: cardHeight)
        .frame(maxWidth: .infinity)
        .overlay(Rectangle().stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1))
        .onTapGesture {
            flipCard()
        }
        .rotation3DEffect(.degrees(cardRotation), axis: (x: 0, y: 1, z: 0))
    }
    
    func flipCard() {
        withAnimation(Animation.linear(duration: 0.5)) {
            cardRotation += 180
            isFlipped.toggle()
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(0.25)) {
            contentRotation += 180
            
        }
    }
}

#Preview {
    FlippyCard(front: {Text("Front")}, back: {Text("Back")})
}
