//
//  Covid.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/14/20.
//

import Foundation

struct CovidWrap:Decodable {
    let Global: GlobalInfo
    let Countries: [CountryInfo]
}

struct GlobalInfo: Decodable {
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
}

struct CountryInfo: Decodable {
    let Country: String
    let CountryCode: String
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let TotalRecovered: Int
}
