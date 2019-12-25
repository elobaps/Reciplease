//
//  String.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 08/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - String

extension String {
    
    /// Check if a string contains at least one element
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
    
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
