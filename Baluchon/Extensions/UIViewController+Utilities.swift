//
//  UIViewController+Utilities.swift
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
    
    /// Hide the iOS keyboatd. When called the UITextField provided is no longer first responder
    /// - Parameter firstResponder:UITextField to make resign
    func dismissKeyboard(firstResponder: UITextField) {
        firstResponder.resignFirstResponder()
    }
    
    
    func toggleActivityIndicator(hide: UIView, display: UIView) {
        hide.isHidden = true
        display.isHidden = false
    }
}
