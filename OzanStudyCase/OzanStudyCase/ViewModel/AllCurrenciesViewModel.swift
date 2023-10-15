//
//  AllCurrenciesViewModel.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import Foundation

protocol AllCurrenciesViewModelDelegate {
    func updateCell()
}

class AllCurrenciesViewModel {
    
    public var didSuccess: ()->() = { }
    
    var currencyData: CryptoListingResponse?
    var delegate: AllCurrenciesViewModelDelegate?
    
    private let sourcesURL = URL(string: "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins")!
    
    func apiToGetCurrencyData(completion : @escaping () -> ()) {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: sourcesURL) { (data, response, error) in
            if error != nil {
                print(error)
            }
            if let safeData = data {
                if let coins = self.parseJSON(coinsData: safeData) {
                    self.currencyData = coins
                    self.delegate?.updateCell()
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(coinsData: Data) -> CryptoListingResponse? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CryptoListingResponse.self, from: coinsData)
            self.currencyData = decodeData
            
            return self.currencyData
        } catch {
            print(error)
            return nil
        }
        
    }
    
    func getCoinsCount() -> Int {
        if let count = currencyData?.data?.coins.count {
            return count
        } else {
            return 1
        }
    }
    
}
