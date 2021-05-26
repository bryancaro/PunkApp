//
//  Utilities.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import UIKit
import SwiftUI

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let bluerEffect = UIBlurEffect(style: style)
        let bluerView = UIVisualEffectView(effect: bluerEffect)
        bluerView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bluerView, at: 0)
        
        NSLayoutConstraint.activate([
            bluerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bluerView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct CardShimmer : View {
    @State var show = false
    var center      = (screen.width / 2) + 110
    var width       : CGFloat
    var height      : CGFloat
    
    var body : some View{
        ZStack {
            if width == 0 {
                Color.black.opacity(0.09)
                    .cornerRadius(10)
                
                Color.white
                    .cornerRadius(10)
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(0.3), .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .rotationEffect(.init(degrees: 60))
                            .offset(x: show ? center : -center)
                            .animation(Animation.default.speed(0.35).delay(0).repeatForever(autoreverses: false))
                    )
                    .onAppear {
                        show.toggle()
                    }
            } else {
                Color.black.opacity(0.09)
                    .frame(width: width, height: height, alignment: .center)
                    .cornerRadius(10)
                
                Color.white
                    .frame(width: width, height: height, alignment: .center)
                    .cornerRadius(10)
                    .mask(
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(0.3), .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .rotationEffect(.init(degrees: 60))
                            .offset(x: show ? center : -center)
                            .animation(Animation.default.speed(0.35).delay(0).repeatForever(autoreverses: false))
                    )
                    .onAppear {
                        show.toggle()
                    }
            }
        }
    }
}

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}
