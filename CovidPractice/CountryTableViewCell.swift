//
//  CountryTableViewCell.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/15/20.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var confirmedCase: UILabel!
    @IBOutlet weak var deathCase: UILabel!
    @IBOutlet weak var recoveryCase: UILabel!
    
    func configureCell(_ country: CountryInfo) {
        flagLabel.text = flag(country.CountryCode)
        countryName.text = country.Country
        confirmedCase.text = "Total confirmed: \(country.TotalConfirmed.description)"
        deathCase.text = "Total dead: \(country.TotalDeaths.description)"
        recoveryCase.text = "Total recovered: \(country.TotalRecovered.description)"
    }
    
    private func flag(_ countryCo: String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in countryCo.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
    
}
