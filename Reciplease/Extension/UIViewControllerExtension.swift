//
//  UIViewControllerExtension.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 08/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

// MARK: Present alert

extension UIViewController {
    
    /// Method that manage alerts which will be used in my model
    func presentAlert(titre: String, message: String) {
        let alertVC = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
