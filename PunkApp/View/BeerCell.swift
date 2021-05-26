//
//  BeerCell.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BeerCell: View {
    var viewModel: BeerCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: viewModel.image)
                    .resizable()
                    .placeholder {
                        Image("B1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100, alignment: .center)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
//                    .padding(10)
                
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.custom("AvenirNext-Medium", size: 20))
                        .foregroundColor(.black)
                    
                    Text(viewModel.subTitle)
                        .font(.custom("AvenirNext-Regular", size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .padding()
        .frame(width: screen.width - 80, height: 100, alignment: .center)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2) , radius: 10, x: 3, y: 3)
    }
}

struct BeerCell_Previews: PreviewProvider {
    static var previews: some View {
        BeerCell(viewModel: BeerCellViewModel(beer: Beer(id: 0, name: "", first_brewed: "", description: "", image_url: "", abv: 0, ibu: 0, ebc: 0, ph: 0, attenuation_level: 0, food_pairing: [String](), volume: Volume(value: 0, unit: ""), ingredients: Ingredients(malt: [Ingredient](), hops: [Ingredient]()))))
    }
}

/*
 Image("B1")
     .resizable()
     .placeholder {
         CardShimmer(width: 60, height: 60)
     }
     .transition(.fade(duration: 0.5))
     .aspectRatio(contentMode: .fill)
     .frame(width: 60, height: 60, alignment: .center)
     .background(Color.white)
     .clipShape(RoundedRectangle(cornerRadius: 10))
 */


