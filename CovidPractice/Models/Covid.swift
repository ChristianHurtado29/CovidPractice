//
//  Covid.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/14/20.
//

import Foundation

struct CovidWrap: Decodable {
    let Global: GlobalInfo
    let Countries: [CountryInfo]
}

struct GlobalInfo: Decodable {
    let NewConfirmed: Int
    let TotalConfirmed: Int
    let NewDeaths: Int
    let TotalDeaths: Int
    let NewRecovered: Int
    let TotalRecovered: Int
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

struct Country: Decodable {
    let name: String
    let alpha2Code: String
    let alpha3Code: String
    let capital: String
    let subregion: String
    let population: Int
    let demonym: String
    let flag: String
}
