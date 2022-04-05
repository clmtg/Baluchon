//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Clément Garcia on 27/03/2022.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Var
    //Instance of the model
    let currency = CurrencyService()
    
    // MARK: - IBOutlets
    //Text field where user provided amount to convert
    @IBOutlet weak var textFieldLocalAmount: UITextField!
    //Label used to display amount converted
    @IBOutlet weak var labelResult: UILabel!
    //Activity indicator to display while network calls are being performed
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //Button used to request convertion by user
    @IBOutlet weak var buttonConvert: UIButton!
    
    
    // MARK: - IBActions
    // Functions call when the user tapped on Convert button
    @IBAction func tappedConvertButton(_ sender: Any) {
        toggleActivityIndicator(indicator: activityIndicator)
        convertAmount()
        toggleActivityIndicator(indicator: activityIndicator)
        dismissKeyboard(firstResponder: textFieldLocalAmount)
    }
    
    @IBAction func tappedToHideKeyboard(_ sender: Any) {
        dismissKeyboard(firstResponder: textFieldLocalAmount)
    }
    
    // MARK: - Functions
    /// Convert the amount provided by the user and display it within the view
    func convertAmount(){
        currency.retreiveRates { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self!.displayResult(rateUSD: data.rates["USD"]!)
                case .failure(let error):
                    let openSettingsAction = UIAlertAction(title: "Open Wi-Fi settings", style: .default) { actionTonOpen in
                        if let url = URL.init(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    let additionalAlertAction = [openSettingsAction]
                    self?.displayAnAlert(title: "Network error", message: "Fail to retreive exchange rate. \(error.description)\nPlease check your network settings", actions: additionalAlertAction)
                }
            }
        }
    }
    
    /// Display it using labelResult (Amount calculted is processed by the model instance)
    /// - Parameter rateUSD: Current exchange rates for USD
    func displayResult(rateUSD: Double){
        guard let untextFieldLocalAmount = textFieldLocalAmount.text else {
            displayAnAlert(title: "Error", message: "The amount provided appears to be incorrect", actions: nil)
            return
        }
        guard untextFieldLocalAmount.isEmpty == false else {
            displayAnAlert(title: "Error", message: "No amount has been provided", actions: nil)
            return
        }
        guard let untextFieldLocalAmount = Double(untextFieldLocalAmount) else {
            displayAnAlert(title: "Error", message: "The amount provided is't valid", actions: nil)
            return
        }
        
        let finalAmount = currency.convertAmount(from: untextFieldLocalAmount, with: rateUSD)
        labelResult.text = String(format: "%.2f", finalAmount)
    }
}
