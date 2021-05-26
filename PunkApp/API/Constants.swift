//
//  Constants.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import Foundation

struct Constants {
    static let URL = { (page: Int) -> String in
        return "https://api.punkapi.com/v2/beers?page=\(page)&per_page=20"
    }
}
