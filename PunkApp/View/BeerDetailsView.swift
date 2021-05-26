//
//  BeerDetailsView.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BeerDetailsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var viewModel: BeerCellViewModel
        
    var body: some View {
        ZStack {
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
                .frame(width: screen.width)
                .offset(x: -screen.width/2)
            
            ScrollView {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(viewModel.title)
                            .font(.custom("AvenirNext-Bold", size: 25))
                        
                        Text(viewModel.description)
                            .font(.custom("AvenirNext-Regular", size: 13))
                            .multilineTextAlignment(.leading)
                        
                        VStack(alignment: .leading) {
                            Text("Brew Sheet")
                                .font(.custom("AvenirNext-Medium", size: 25))
                            
                            HStack {
                                CircleProgressBar(title: "ABV", progress: viewModel.abv)
                                    .frame(width: 80, height: 80)
                                    .padding(10)
                                
                                CircleProgressBar(title: "IBU",progress: viewModel.ibu)
                                    .frame(width: 80, height: 80)
                                    .padding(10)
                            }
                            
                            HStack {
                                CircleProgressBar(title: "PH",progress: viewModel.ph)
                                    .frame(width: 80, height: 80)
                                    .padding(10)
                                
                                CircleProgressBar(title: "EBC",progress: viewModel.ebc)
                                    .frame(width: 80, height: 80)
                                    .padding(10)
                            }
                            
                            ProgressBar(title: "Volumen", unit: "ml", value: viewModel.volume)
                            
                            ProgressBar(title: "Attenuation Level", unit: "ml", value: viewModel.attenuationLevel)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Ingredients")
                                .font(.custom("AvenirNext-Medium", size: 25))
                            
                            if !viewModel.hops.isEmpty {
                                Text("Hops:")
                                    .font(.custom("AvenirNext-Demibold", size: 18))
                                
                                ForEach(viewModel.hops, id: \.self) { ingredient in
                                    HStack {
                                        Circle()
                                            .foregroundColor(colorScheme == .light ? .black : .white)
                                            .frame(width: 6, height: 6, alignment: .center)
                                        
                                        Text(ingredient.name)
                                            .font(.custom("AvenirNext-Regular", size: 15))
                                    }
                                    .padding(.leading, 10)
                                }
                            }

                            if !viewModel.malt.isEmpty {
                                Text("Malt:")
                                    .font(.custom("AvenirNext-Demibold", size: 18))
                                
                                ForEach(viewModel.malt, id: \.self) { ingredient in
                                    HStack {
                                        Circle()
                                            .foregroundColor(colorScheme == .light ? .black : .white)
                                            .frame(width: 6, height: 6, alignment: .center)
                                        
                                        Text(ingredient.name)
                                            .font(.custom("AvenirNext-Regular", size: 15))
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Food Pairing")
                                .font(.custom("AvenirNext-Medium", size: 25))
                            
                            ForEach(viewModel.foodPairing, id: \.self) { food in
                                HStack {
                                    Circle()
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                        .frame(width: 6, height: 6, alignment: .center)
                                    
                                    Text(food)
                                        .font(.custom("AvenirNext-Regular", size: 15))
                                }
                                .padding(.leading, 10)
                            }
                        }
                    }
                    .padding(10)
                    .frame(width: screen.width / 2 + 80)
                    .background(BlurView(style: .extraLight))
                    .cornerRadius(10)
                    .padding(.trailing, 2)
                }
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct BeerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailsView(viewModel: BeerCellViewModel(beer: emptyBeer))
    }
}

struct CircleProgressBar: View {
    var title: String
    var progress: Double
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 5.0)
                    .opacity(0.3)
                    .foregroundColor(Color.yellow)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress/100, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.yellow)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                
                Text("\(progress, specifier: "%.2f")")
                    .font(.custom("AvenirNext-Medium", size: 12))
            }
            .shadow(color: Color.yellow.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
            
            Text(title)
                .font(.custom("AvenirNext-Medium", size: 13))
        }
    }
}

struct ProgressBar: View {
    var title: String
    var unit : String
    var value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.custom("AvenirNext-Medium", size: 15))
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.2)
                        .foregroundColor(.yellow)
                    
                    Rectangle()
                        .frame(width: min(CGFloat(value/120)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(.yellow)
                        .animation(.linear)
                }
                .cornerRadius(45.0)
            }
            
            HStack {
                Spacer()
                Text("\(value, specifier: "%.2f")\(unit)")
                    .font(.custom("AvenirNext-Medium", size: 12))
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal)
        
    }
}
