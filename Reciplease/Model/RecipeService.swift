//
//  RecipeService.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 06/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - Edanam Errors

enum EdamamError: Error {
    case noData, incorrectResponse, undecodable
}

final class RecipeService: EncoderUrl {
    
    // MARK: - Properties
    
    private let session: AlamoSession
    
    // MARK: - Initializer
    
    init(session: AlamoSession = RecipeSession()) {
        self.session = session
    }
    
    // MARK: - Methods
    
    /// network call
    func getRecipes(ingredientList: String, callback: @escaping (Result<RecipeData, Error>) -> Void) {
        guard let baseUrl = URL(string: "https://api.edamam.com/search?") else { return }
        
        let parameters: [(String, String)] = [("app_id", ApiConfig.edamamId), ("app_key", ApiConfig.edamamApiKey), ("q", ingredientList)]
        let url = encode(baseUrl: baseUrl, parameters: parameters)
        
        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(EdamamError.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(EdamamError.incorrectResponse))
                return print(url)
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipeData.self, from: data) else {
                callback(.failure(EdamamError.undecodable))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}
