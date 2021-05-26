//
//  Beer.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import Foundation

struct Beer: Identifiable, Codable, Hashable {
    let id                : Int
    let name              : String?
    let first_brewed      : String?
    let description       : String?
    let image_url         : String?
    let abv               : Double?
    let ibu               : Double?
    let ebc               : Double?
    let ph                : Double?
    let attenuation_level : Double?
    let food_pairing      : [String]?
    let volume            : Volume?
    let ingredients       : Ingredients?
}

struct Volume: Codable, Hashable {
    let value : Double
    let unit  : String
}

struct Ingredients: Codable, Hashable {
    let malt : [Ingredient]
    let hops : [Ingredient]
}

struct Ingredient: Codable, Hashable {
    let name : String
}
