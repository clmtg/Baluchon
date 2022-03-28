//
//  ExtensionAlert.swift
//  Baluchon
//
//  Created by Clément Garcia on 28/03/2022.
//

import UIKit


extension UIViewController {
   
    func displayAnAlert(title: String, message: String, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }

        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
