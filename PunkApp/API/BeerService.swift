//
//  BeerService.swift
//  PunkApp
//
//  Created by Bryan Caro on 5/26/21.
//

import Foundation

class BeerService {
    static public func fetchBeers(page: Int, completion: @escaping ([Beer]?, Error?) -> Void) {
        let url = URL(string: Constants.URL(page))!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response else {
                completion(nil, error)
                return
            }
            let httpResponse2 = httpResponse as! HTTPURLResponse
            print("API RESPONSE CODE: \(httpResponse2.statusCode)")
            
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain {
                    print("contact host error")
                    completion(nil, error)
                } else {
                    print("something went wrong")
                    completion(nil, error)
                }
            }
            
            
            guard let data = data else {
                print("No data fetched")
                return
            }
            
            let decoder = JSONDecoder()

            do {
                let details = try decoder.decode([Beer].self, from: data)
                print(details)
                completion(details, nil)
                
            } catch {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }.resume()
    }
}
