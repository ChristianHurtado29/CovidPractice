//
//  ViewController.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/14/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countrySearch: UISearchBar!
    @IBOutlet weak var countriesTableView: UITableView!
    let apiClient = CovidAPI()
    
    private var countries = [CountryInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.countriesTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountryInfo()
        countriesTableView.dataSource = self
        countrySearch.delegate = self
    }
    
    private func loadCountryInfo() {
        apiClient.loadCovidInfo { (result) in
            switch result {
            case .failure(let error):
                print("error is \(error.localizedDescription)")
            case .success(let countryInfo):
                self.countries = countryInfo
            }
        }
    }
    
    func flag(countryCo:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in countryCo.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = countriesTableView.dequeueReusableCell(withIdentifier: "countryCell") else {
            fatalError("could not find cell/indexpath")
        }
        
        let country = countries[indexPath.row]
        let countryFlag = flag(countryCo: country.CountryCode)
        cell.textLabel?.text = "\(country.Country) \(countryFlag)"
        cell.detailTextLabel?.text = "Confirmed: \(country.TotalConfirmed.description), Recovered: \(country.TotalRecovered.description)"
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            loadCountryInfo()
        }

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        countries = countries.filter { $0.Country.contains(searchBar.text!)}
        self.countriesTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}
