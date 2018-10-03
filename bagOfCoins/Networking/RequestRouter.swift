//
//  RequestRouter.swift
//  bagOfCoins
//
//  Created by Daniel Hakimi on 30/09/2018.
//  Copyright © 2018 Daniel Hakimi. All rights reserved.
//

import Foundation

public enum CMCEndPoint {
    case getCoins
}

public struct RequestRouter {

    enum HTTPMethod: String {
        case get = "GET"
    }

    let baseUrl: String = "https://pro-api.coinmarketcap.com/v1/cryptocurrency"
    let endPoint: CMCEndPoint
    let method: HTTPMethod
    let params: [String: Any]?
    var headers: [String: String] = ["X-CMC_PRO_API_KEY": "c5e6359c-7f99-4a14-80d0-44385c2ccfb1"] // default header

    var path: String {
        switch endPoint {
        case .getCoins: return "\(baseUrl)/listings/latest?limit=5"
        }
    }

    init(endPoint: CMCEndPoint,
         method: HTTPMethod = .get,
         params: [String: Any]? = nil,
         headers: [String: String] = [:]) {

        self.endPoint = endPoint
        self.method = method
        self.params = params

        headers.forEach { self.headers[$0.key] = $0.value }
    }
}
