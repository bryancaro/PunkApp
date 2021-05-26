//
//  HomeView.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    // ViewModel
    @ObservedObject var viewModel = BeerViewModel()
    
    // Page Index
    @State var page = 1
    
    // Search
    @State var searchBeer = ""
    
    // Show Alert View
    @State var showAlert        = false
    @State var alertViewMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Header()
                
                VStack {
                    ScrollView {
                        HStack {
                            Image("Search")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .padding(.leading, 8)
                            
                            TextField("Buscar...", text: $searchBeer)
                                .font(.custom("AvenirNext-Bold", size: 15))
                                .foregroundColor(.black)
                        }
                        .padding(5)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .frame(width: screen.width - 50, alignment: .leading)
                        .padding(.top)
                        
                        VStack(spacing: 20) {
                            if !viewModel.store.isEmpty {
                                ForEach(searchBeer.isEmpty ? viewModel.store : viewModel.store.filter({"\($0.title)".contains(searchBeer)}), id: \.self) { data in
                                    NavigationLink(
                                        destination: BeerDetailsView(viewModel: data),
                                        label: {
                                            BeerCell(viewModel: data)
                                        })
                                }
                                .transition(.scale)
                            } else {
                                LoadingView()
                                    .transition(.fade)
                            }
                        }
                        .frame(width: screen.width, alignment: .top)
                        .padding(.top)
                        
                        PaginationView(page: $page, nextPage: {
                            impact(style: .soft)
                            if !viewModel.store.isEmpty {
                                page += 1
                            }
                            
                            viewModel.fetchPage(page: page)
                        }, previousPage: {
                            if page != 1 {
                                impact(style: .soft)
                                page -= 1
                                viewModel.fetchPage(page: page)
                            }
                        })
                    }
                    
                    Spacer()
                }
                .frame(width: screen.width, alignment: .top)
                .background(Color(.white))
                .cornerRadius(28)
                .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 0)
                .edgesIgnoringSafeArea(.bottom)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Alert"), message: Text(viewModel.alertViewMessage), dismissButton: .cancel(Text("OK"), action: {
                    viewModel.showAlert = false
                }))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct Header: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Beer App")
                            .font(.custom("AvenirNext-Regular", size: 18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        
                        Text("Welcome to PunkApp")
                            .font(.custom("AvenirNext-Bold", size: 25))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Image("L1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                .padding(.top, 40)
                .padding(.horizontal)
            }
            .frame(width: screen.width, height: 180, alignment: .top)
            .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
            .cornerRadius(28)
            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 0)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}
