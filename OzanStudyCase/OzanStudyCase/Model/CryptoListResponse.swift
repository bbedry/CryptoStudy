//
//  CryptoListResponse.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import Foundation


struct CryptoListingResponse: Codable {
    let status: String?
    let data: CryptoListingData?
}
//
//struct CryptoListingStatus: Codable {
//    let success: String
//    let error: String
//}

struct CryptoListingData: Codable {
    var stats: CryptoListStat?
    var coins: [Coins]?
  
}

struct CryptoListStat: Codable {
    var total: Double?
    var totalCoins: Double?
    var totalMarkets: Double?
    var totalExchanges: Double?
    var totalMarketCap: String?
    var total24hVolume: String?
}

struct Coins: Codable {
    var uuid: String?
    var symbol: String?
    var name: String?
    var color: String?
    var iconUrl: String?
    var marketCap: String?
    var price: String?
    var listedAt: Int?
    var tier: Int?
    var change: String?
    var rank: Int?
    var sparkline: [String]? = []
    var lowVolume: Bool?
    var coinrankingUrl: String?
    var dailyVolume: String?
    var btcPrice: String?
}

