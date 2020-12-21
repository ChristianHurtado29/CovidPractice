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
//    @IBOutlet weak var deathCase: UILabel!
//    @IBOutlet weak var recoveryCase: UILabel!
    
    func formatCommas(_ num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNum = formatter.string(from: NSNumber(value: num))
        return formattedNum!
    }
//
    func configureCell(_ country: CountryInfo) {
        flagLabel.text = flag(country.countryCode)
        countryName.text = country.country
        confirmedCase.text = "# of cases: \(formatCommas(country.totalConfirmed))"
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
