//
//  LottieView.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    var mode: LottieLoopMode
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = mode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}

/*
 import SwiftUI

 struct LoadingView: View {
     @Binding var show: Bool
     @Binding var show2: Bool
     var title: String
     var name: String
     
     var body: some View {
         VStack {
             Text(title)
                 .font(.headline)
                 .bold()
                 .multilineTextAlignment(.center)
             
             if show || show2 {
                 LottieView(filename: name, mode: .loop)
                     .frame(width: 180, height: 180)
                     .transition(.fade(duration: 0.4))
             }
         }
         .frame(width: 250, height: 250)
         .padding()
         .background(BlurView(style: .systemMaterial))
         .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
         .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
         .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         
         .opacity(show || show2 ? 1 : 0)
         .offset(x: show || show2 ? 0 : screen.height)
         .animation(.linear(duration: 0.5))
         
     }
 }

 struct LoadingView_Previews: PreviewProvider {
     static var previews: some View {
         LoadingView(show: .constant(true), show2: .constant(false), title: "Estamos construyendo mejores experiencias para ti", name: "loadingData")
             .environment(\.colorScheme, .dark)
     }
 }
 */
