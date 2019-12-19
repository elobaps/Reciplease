//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Elodie-Anne Parquer on 19/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipeData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}
