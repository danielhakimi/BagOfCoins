//
//  Coin.swift
//  bagOfCoins
//
//  Created by Daniel Hakimi on 30/09/2018.
//  Copyright © 2018 Daniel Hakimi. All rights reserved.
//

import Foundation

struct CoinContainer: Codable {
    let data: [Coin]
}

struct Coin: Codable {
    let id: Int
    let name, symbol, slug: String?
    let numMarketPairs, circulatingSupply, totalSupply: Double
    let cmcRank: Int
    let maxSupply: Double?
    let lastUpdated, dateAdded: String
    let quote: [String: Quote]

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case cmcRank = "cmc_rank"
        case numMarketPairs = "num_market_pairs"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case lastUpdated = "last_updated"
        case dateAdded = "date_added"
        case quote
    }
}

struct Quote: Codable {
    var formattedPrice: String?
    var price: Double
//    let volume24H: Double
//    let percentChange1H, percentChange24H, percentChange7D: Double
//    let marketCap: Double
//    let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case price
//        case volume24H = "volume_24h"
//        case percentChange1H = "percent_change_1h"
//        case percentChange24H = "percent_change_24h"
//        case percentChange7D = "percent_change_7d"
//        case marketCap = "market_cap"
//        case lastUpdated = "last_updated"
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        price = try container.decode(Double.self, forKey: .price)

        formattedPrice = String(format: "%.2f", price)
    }
}
