//
// Created by Daniel Hakimi on 30/09/2018.
// Copyright (c) 2018 Daniel Hakimi. All rights reserved.
//

import Foundation

class CoinService {

    let webApi: DataRequestProtocol

    init(webApi: DataRequestProtocol) {
        self.webApi = webApi
    }

    func getAllCoins(onSuccess: @escaping ([Coin]) -> Void, failure: @escaping (Error) -> Void) {

        webApi.execute(
            requestData: RequestRouter(endPoint: .getCoins),
            onSuccess: { (container: CoinContainer) in
                onSuccess(container.data)
        }, onFailure: failure)
    }
}
