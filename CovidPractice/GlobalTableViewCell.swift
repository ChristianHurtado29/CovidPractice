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
    
    func configureCell() {
        totalCases.text =  "ok"
//        totalRecovered.text = "Total Recovered: \(globe.NewDeaths.description)"
//        totalDead.text = "Total Dead: \(globe.TotalDeaths.description)"
    }
    
}
