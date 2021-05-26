//
//  BeerViewModel.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import Foundation
import SwiftUI
import Combine

class BeerViewModel: ObservableObject {
    @Published var store            = [BeerCellViewModel]()
    @Published var showAlert        = false
    @Published var alertViewMessage = ""
    
    init() {
        BeerService.fetchBeers(page: 1) { data, error in
            if let error = error {
                print("DEBUG: Failed fetching beers \(error.localizedDescription)")
                haptic(type: .error)
                self.alertViewMessage = error.localizedDescription
                self.showAlert        = true
                
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.store = data.map(BeerCellViewModel.init)
            }
        }
    }
    
    func fetchPage(page: Int) {
        BeerService.fetchBeers(page: page) { data, error in
            if let error = error {
                print("DEBUG: Failed fetching beers \(error.localizedDescription)")
                haptic(type: .error)
                self.alertViewMessage = error.localizedDescription
                self.showAlert        = true
                
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.store = data.map(BeerCellViewModel.init)
            }
        }
    }
}

struct BeerCellViewModel: Hashable {
    var beer: Beer
    
    var title: String {
        return beer.name ?? ""
    }
    
    var subTitle: String {
        return beer.first_brewed ?? ""
    }
    
    var image: URL? {
        return URL(string: beer.image_url ?? "")
    }
    
    var description: String {
        return beer.description ?? ""
    }
    
    var abv: Double {
        return beer.abv ?? 0
    }
    
    var ibu: Double {
        return beer.ibu ?? 0
    }
    
    var ph: Double {
        return beer.ph ?? 0
    }
    
    var ebc: Double {
        return beer.ebc ?? 0
    }
    
    var volume: Double {
        return beer.volume?.value ?? 0
    }
    
    var attenuationLevel: Double {
        return beer.attenuation_level ?? 0
    }
    
    var hops: [Ingredient] {
        return beer.ingredients?.hops ?? [Ingredient]()
    }
    
    var malt: [Ingredient] {
        return beer.ingredients?.malt ?? [Ingredient]()
    }
    
    var foodPairing: [String] {
        return beer.food_pairing ?? [String]()
    }
        
    init(beer: Beer) {
        self.beer = beer
    }
}

let emptyBeer = Beer(id: 0, name: "", first_brewed: "", description: "", image_url: "", abv: 0, ibu: 0, ebc: 0, ph: 0, attenuation_level: 0, food_pairing: [String](), volume: nil, ingredients: nil)
