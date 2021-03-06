//
//  ViewController.swift
//  CovidPractice
//
//  Created by Christian Hurtado on 12/14/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countrySearch: UISearchBar!
    @IBOutlet weak var globalTableView: UITableView!
    @IBOutlet weak var countriesTableView: UITableView!
    let apiClient = CovidAPI()
    
    private var countries = [CountryInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.countriesTableView.reloadData()
            }
        }
    }
    
    private var globalInfo: GlobalInfo? {
        didSet {
            DispatchQueue.main.async {
                self.globalTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountryInfo()
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        globalTableView.dataSource = self
        globalTableView.delegate = self
        globalTableView.backgroundColor = .systemOrange
        countrySearch.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailedViewController, let indexPath = countriesTableView.indexPathForSelectedRow else {
            fatalError("could not identify country selected")
        }
        let country = countries[indexPath.row]
        detailVC.country = country
    }
    
    private func loadCountryInfo() {
        apiClient.loadCovidInfo { (result) in
            switch result {
            case .failure(let error):
                print("error is \(error.localizedDescription)")
            case .success(let covidInfo):
                self.globalInfo = covidInfo.global
                self.countries = covidInfo.countries
                dump(self.globalInfo)
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case countriesTableView:
            return countries.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == countriesTableView {
            return "Countries"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case countriesTableView:
            guard let cell = countriesTableView.dequeueReusableCell(withIdentifier: "countryCell") as? CountryTableViewCell else {
                fatalError("could not find cell/indexpath")
            }
            let country = countries[indexPath.row]
            cell.configureCell(country)
            return cell
        default:
            guard let cell = globalTableView.dequeueReusableCell(withIdentifier: "globalCell") as? GlobalTableViewCell else {
                fatalError("could not find cell/indexpath")
            }
            let globe = globalInfo
            cell.configureCell(globe)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == globalTableView {
            return 170
        } else {
            return 130
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            loadCountryInfo()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        countries = countries.filter { $0.country.contains(searchBar.text!)}
        self.countriesTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}
