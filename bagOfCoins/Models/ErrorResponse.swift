//
// Created by Daniel Hakimi on 30/09/2018.
// Copyright (c) 2018 Daniel Hakimi. All rights reserved.
//

import Foundation

public struct ErrorResponse: Error {
    let errorMessage: String?
    let responseCode: Int?

    init(message: String?, responseCode: Int?) {
        self.errorMessage = message
        self.responseCode = responseCode
    }
}