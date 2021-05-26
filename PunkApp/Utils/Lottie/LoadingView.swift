//
//  LoadingView.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import SwiftUI

struct LoadingView: View {
    @State var show = false
    
    var body: some View {
        VStack {
            Text("Searching...")
                .font(.custom("AvenirNext-Regular", size: 15))
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.2))
            
            LottieView(filename: "Loading", mode: .loop)
                .frame(width: 150, height: 150)
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.4))
        }
        .padding(30)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear {
            show = true
        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
