import Foundation
import UIKit

class ViewModel {
    
    var result = Bindable<String?>(nil)
    var countriesArray = Bindable<[VPN]?>(nil)
    var selectedCountryIndex = Bindable<Int?>(nil)
    
    let myCountriesArray = [
        VPN(counrtyName: "Spain", countryImage: "ES"),
        VPN(counrtyName: "France", countryImage: "FR"),
        VPN(counrtyName: "Gernamy", countryImage: "DE"),
        VPN(counrtyName: "Japan", countryImage: "JP"),
        VPN(counrtyName: "United Kingdom", countryImage: "UK"),
        VPN(counrtyName: "Unated States", countryImage: "US")
    ]
    
    func loadCountriesList() {
        countriesArray.value = myCountriesArray
    }
    
    
    func sendRequest(index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.selectedCountryIndex.value = index
        }
    }
    
    func randomCountrySelect () {
        guard let numberOfCountriesIndexes = countriesArray.value?.count else {return}
        let randomIndex = Int.random(in: 0...numberOfCountriesIndexes - 1)
        print(randomIndex)
        sendRequest(index: randomIndex)
    }
}
