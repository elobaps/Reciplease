//
//  In.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 09/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - Int

extension Int {
    
    /// Method that creates string representation of  time's quantities
    func timeFormater() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.hour, .minute]
        guard let formattedSring = formatter.string(from: TimeInterval(self)) else { return "" }
        return formattedSring
    }
}
