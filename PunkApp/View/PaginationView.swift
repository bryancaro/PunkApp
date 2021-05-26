//
//  PaginationView.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import SwiftUI

struct PaginationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var page : Int
    var nextPage      : () -> Void
    var previousPage  : () -> Void
    
    var body: some View {
        HStack {
            Button(action: previousPage, label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(.black)
                    .frame(width: 35, height: 35)
                    .background(Color.clear)
                    .cornerRadius(20)
            })
            .buttonStyle(PlainButtonStyle())
            
            Text("\(page)")
                .font(.custom("AvenirNext-Medium", size: 20))
                .foregroundColor(.black)
            
            Button(action: nextPage, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .foregroundColor(.black)
                    .frame(width: 35, height: 35)
                    .background(Color.clear)
                    .cornerRadius(20)
            })
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

struct PaginationView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationView(page: .constant(1), nextPage: {}, previousPage: {})
    }
}
