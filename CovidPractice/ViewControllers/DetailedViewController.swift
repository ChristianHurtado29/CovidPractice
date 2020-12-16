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
    
    func fetchImage(str: String) {
        guard let url = URL(string: str) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("error in photo retrieve \(error.localizedDescription)")
            }
            if let data = data {
                DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.countryFlag.image = image
                }
            }
        }
        dataTask.resume()
    }
    
    func fillInfo() {
        apiClient.loadCountryInfo(countryName: self.country.Country) { (result) in
            switch result {
            case .failure(let error):
                print("error in loading country info: \(error)")
            case .success(let basicCountry):
                DispatchQueue.main.async {
                    let recoveredPct = Double(self.country.TotalRecovered) / Double(self.country.TotalConfirmed) * 100.0
                    let deathPct = Double(self.country.TotalDeaths) / Double(self.country.TotalConfirmed) * 100
                    self.countryCapital.text = "Capital: \(basicCountry.first?.capital ?? "no cap")"
                    self.countryPopulation.text = "Population: \(basicCountry.first?.population.description ?? "no pop")"
                    self.countryName.text = basicCountry.first?.name
                    self.summaryText.text = "The most recent information states that the \(basicCountry.first?.subregion ?? "")n nation has \(self.country.NewConfirmed) new cases, bringing their total cases to \(self.country.TotalConfirmed). To date, \(self.country.TotalRecovered) \(basicCountry.first?.demonym ?? "")s have made full recoveries(% \(recoveredPct.description), while \(self.country.TotalDeaths) have died (% \(deathPct.description))."
                    self.fetchImage(str: basicCountry.first!.flag)
//                    let urlImage = URL(string: basicCountry.first!.flag)
                }
            }
        }
    }
}
