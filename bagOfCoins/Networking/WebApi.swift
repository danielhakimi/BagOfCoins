//
// Created by Daniel Hakimi on 30/09/2018.
// Copyright (c) 2018 Daniel Hakimi. All rights reserved.
//

import Foundation

public protocol NetworkDispatcher {
    func dispatch(request: RequestRouter, onSuccess: @escaping (Data) -> Void, onFailure: @escaping (Error) -> Void)
}

public protocol DataRequestProtocol {

    func execute<T: Codable> (
            requestData: RequestRouter,
            onSuccess: @escaping (T) -> Void,
            onFailure: @escaping (Error) -> Void)
}

class WebApi: NetworkDispatcher, DataRequestProtocol {

    func dispatch(request requestData: RequestRouter, onSuccess: @escaping (Data) -> Void, onFailure: @escaping (Error) -> Void) {

        guard let url = URL(string: requestData.path) else {
            onFailure(ErrorResponse(message: "could not create url with given endpoint: \(requestData.path)", responseCode: nil))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestData.method.rawValue

        requestData.headers.enumerated().forEach {
            urlRequest.addValue($0.element.value, forHTTPHeaderField: $0.element.key)
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) -> Void in

            let response = response as? HTTPURLResponse

            if let data = data, response?.statusCode == 200 {
                onSuccess(data)
            } else {
                onFailure(ErrorResponse(message: error?.localizedDescription, responseCode: response?.statusCode))
            }

        }.resume()
    }

    func execute<T: Codable>(requestData: RequestRouter, onSuccess: @escaping (T) -> Void, onFailure: @escaping (Error) -> Void) {

        dispatch(request: requestData, onSuccess: { data in
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                guard let jsonObject = jsonResponse else {
                    onFailure(ErrorResponse(message: "could not unwrap json response", responseCode: nil))
                    return
                }

//                print(jsonObject)

                let items = try JSONSerialization.data(withJSONObject: jsonObject)

                let decoded = try JSONDecoder().decode(T.self, from: items)

                DispatchQueue.main.async {
                    onSuccess(decoded)
                }
            } catch let error {
                DispatchQueue.main.async {
                    onFailure(error)
                }
            }

        }, onFailure: { error in

            DispatchQueue.main.async {
                onFailure(error)
            }
        })
    }
}
