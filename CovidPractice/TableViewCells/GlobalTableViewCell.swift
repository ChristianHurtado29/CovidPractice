//
//  GlobalTableViewCell.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/14/20.
//

import UIKit

class GlobalTableViewCell: UITableViewCell {

    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var totalDead: UILabel!
    
    func formatCommas(_ num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNum = formatter.string(from: NSNumber(value: num))
        return formattedNum!
    }
    
    func configureCell(_ globe: GlobalInfo?) {
//        self.backgroundColor = .yellow
        var stringRec = ""
        var stringMort = ""
        if let globe = globe {
            let computedRec = Double(globe.totalRecovered) / Double(globe.totalConfirmed) * 100.0
            let computedMortality = Double(globe.totalDeaths) / Double(globe.totalConfirmed) * 100
            stringRec = String(format: "%.2f", computedRec)
            stringMort = String(format: "%.2f", computedMortality)
        }
        totalCases.text =  "Total Cases: \(formatCommas(globe?.totalConfirmed ?? 0))"
        totalRecovered.text = "Total Recovered: \(formatCommas(globe?.totalRecovered ?? 0))   % \(stringRec)"
        totalDead.text = "Total Dead: \(formatCommas(globe?.totalDeaths ?? 0))              % \(stringMort)"
    }
    
}
