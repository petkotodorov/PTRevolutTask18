//
//  ApiClient.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/15/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import Foundation

class ApiClient {
    
    private let session = URLSession(configuration: .default)
    private let baseUrl = "https://revolut.duckdns.org/latest?base="
    
    private var dataTask: URLSessionDataTask?
    
    func fetchRates(forBaseCurrency base: String? ,completionHandler: @escaping (ResponseResult) -> (Void)) {
        let fullString: String
        if let base = base {
            fullString = baseUrl + base
        } else {
            fullString = baseUrl + "EUR"
        }
        guard let url = URL(string: fullString) else { return }
        stopRunningDataTask()
        dataTask = session.dataTask(with: url) { (data, response, error) in
            let responseResult = self.handleResponse(data: data, response: response, error: error)
            DispatchQueue.main.async {
                completionHandler(responseResult)
            }
        }
        dataTask?.resume()
    }
    
    private func stopRunningDataTask() {
        if dataTask != nil {
            dataTask?.cancel()
            dataTask = nil
        }
    }
}

extension ApiClient {
    
    //checks for both HTTP and server errors
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) -> ResponseResult {
        if let error = error {
            return ResponseResult.failure(error.localizedDescription)
        } else if let data = data,
            let response = response as? HTTPURLResponse {
            if response.statusCode != 200 {
                return ResponseResult.failure("Something went wrong..")
            }
            return ResponseResult.success(data)
        }
        return ResponseResult.failure("Invalid error")
    }
}
