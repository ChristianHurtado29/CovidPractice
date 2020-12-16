//
//  DetailedViewController.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/15/20.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var country: CountryInfo!
    var apiClient = CovidAPI()
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    @IBOutlet weak var summaryText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillInfo()
       
    }
    
    func fillInfo() {
        apiClient.loadCountryInfo(countryName: self.country.Country) { (result) in
            switch result {
            case .failure(let error):
                print("error in loading country info: \(error)")
            case .success(let basicCountry):
                self.countryCapital.text = "Capital: \(basicCountry.capital)"
                self.countryPopulation.text = "Population: \(basicCountry.population.description)"
                self.countryName.text = basicCountry.name
                
            }
        }
    }
    

}
