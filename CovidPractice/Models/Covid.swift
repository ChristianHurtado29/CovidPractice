//
//  Covid.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/14/20.
//

import Foundation

struct CovidWrap: Codable & Equatable {
    let global: GlobalInfo
    let countries: [CountryInfo]
    
    private enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
    
}

struct GlobalInfo: Codable & Equatable {
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    
    private enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}

struct CountryInfo: Codable & Equatable {
    let country: String
    let countryCode: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let totalRecovered: Int
    
    private enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
    }
}

struct Country: Codable & Equatable {
    let name: String
    let alpha2Code: String
    let alpha3Code: String
    let capital: String
    let subregion: String
    let population: Int
    let demonym: String
    let flag: String
}
