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
    @IBOutlet weak var countryFlag: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    @IBOutlet weak var summaryText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillInfo()
        navigationItem.title = "\(country.Country)'s Covid Profile"
    }
    
    func formatCommas(_ num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNum = formatter.string(from: NSNumber(value: num))
        return formattedNum!
    }
    
    func flag(_ countryCo: String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in countryCo.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
        
    func fillInfo() {
        apiClient.loadCountryInfo(countryName: self.country.Country) { (result) in
            switch result {
            case .failure(let error):
                print("error in loading country info: \(error)")
            case .success(let basicCountry):
                DispatchQueue.main.async {
                    let recoveredPct = Double(self.country.TotalRecovered) / Double(self.country.TotalConfirmed) * 100.0
                    let recText: String = String(format: "%.2f", recoveredPct)
                    let deathPct = Double(self.country.TotalDeaths) / Double(self.country.TotalConfirmed) * 100
                    let deathText: String = String(format: "%.2f", deathPct)
                    self.countryCapital.text = "Capital: \(basicCountry.first?.capital ?? "no cap")"
                    self.countryPopulation.text = "Population: \(self.formatCommas(basicCountry.first?.population ?? 0))"
                    self.countryName.text = basicCountry.first?.name
                    self.summaryText.text = "The most recent information states that the \(basicCountry.first?.subregion ?? "")n nation has \(self.formatCommas(self.country.NewConfirmed)) new cases, bringing their total cases to \(self.formatCommas(self.country.TotalConfirmed)). To date, \(self.formatCommas(self.country.TotalRecovered)) \(basicCountry.first?.demonym ?? "")s have made full recoveries(% \(recText)), while \(self.formatCommas(self.country.TotalDeaths)) have died (% \(deathText))."
                    self.countryFlag.text = self.flag(basicCountry.first?.alpha2Code ?? "us")
                }
            }
        }
    }
}
