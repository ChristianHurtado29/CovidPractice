//
//  CovidAPI.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/14/20.
//

import Foundation
import UIKit

class CovidAPI {
   
    func loadCovidInfo(completion: @escaping (Result<CovidWrap, Error>) -> ()) {
        
        let urlEndpoint = "https://api.covid19api.com/summary"
        guard let url = URL(string: urlEndpoint) else {
            fatalError("bad URL")
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("the error is \(error.localizedDescription)")
                return completion(.failure(error))
            }
    
            if let data = data {
                do {
                    let covidResult = try JSONDecoder().decode(CovidWrap.self, from: data)
                    dump(covidResult)
                    return completion(.success(covidResult))
                } catch {
                    print("error in data \(error)")
                }
            }
        }
        dataTask.resume()
    }
}
