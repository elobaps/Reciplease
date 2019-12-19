//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 06/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

final class RecipeSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}


