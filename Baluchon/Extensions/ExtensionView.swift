//
//  ExtensionView.swift
//  Baluchon
//
//  Created by Clément Garcia on 28/03/2022.
//

import UIKit


extension UIViewController {
    
    /// Display an iOS alrt to the user
    /// - Parameters:
    ///   - title: Alert's title
    ///   - message: Alert's message
    ///   - actions: List of action otpions which could be included within the alert. (By default = nil)
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
    
    
    /// Toggle if an activity indicator display
    /// - Parameter indicator: Affected activity indicator to toggle
    func toggleActivityIndicator(indicator: UIActivityIndicatorView) {
        indicator.isHidden = !indicator.isHidden
    }
    
}
