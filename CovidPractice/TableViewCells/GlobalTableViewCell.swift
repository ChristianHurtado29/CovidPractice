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
    
    func configureCell(_ globe: GlobalInfo?) {
        self.backgroundColor = .yellow
        var computedRec = 0.0
        var computedMortality = 0.0
        if let globe = globe {
            computedRec = Double(globe.TotalRecovered) / Double(globe.TotalConfirmed) * 100.0
            computedMortality = Double(globe.TotalDeaths) / Double(globe.TotalConfirmed) * 100
        }
        totalCases.text =  "Total Cases: \(globe?.TotalConfirmed.description ?? "")"
        totalRecovered.text = "Total Recovered: \(globe?.TotalRecovered.description ?? "")  % \(computedRec.description)"
        totalDead.text = "Total Dead: \(globe?.TotalDeaths.description ?? "")               %\(computedMortality)"
    }
    
}
