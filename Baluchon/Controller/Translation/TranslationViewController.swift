//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by Clément Garcia on 31/03/2022.
//

import UIKit

class TranslationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTargetLanguage.selectRow(5, inComponent:0, animated:true)
    }
    
    //DataDource for picker
    private let availableLanguages = ["BG": "Bulgarian", "CS": "Czech", "DA": "Danish", "DE": "German", "EL": "Greek", "EN-GB": "English (British)", "EN-US": "English (American)", "ES": "Spanish", "ET": "Estonian", "FI": "Finnish", "FR": "French", "HU": "Hungarian", "IT": "Italian", "JA": "Japanese", "LT": "Lithuanian", "LV": "Latvian", "NL": "Dutch", "PL": "Polish", "PT-PT": "Portuguese", "PT-BR": "Portuguese (Brazilian)", "RO": "Romanian", "RU": "Russian", "SK": "Slovak", "SL": "Slovenian", "SV": "Swedish", "ZH": "Chinese"]
    
    // MARK: - VAR
    //Model instance
    private let translationCore = TranslationService()
    //Key of the targeted language within the PickerView
    private var selectedTargetLanguageKey: String {
        return Array(availableLanguages)[pickerTargetLanguage.selectedRow(inComponent: 0)].key
    }
    
    // MARK: - IBOutlets
    //Text provided by the user which needs to be translated
    @IBOutlet weak var textViewLocalText: UITextView!
    //Text translated
    @IBOutlet weak var textViewForeignText: UITextView!
    //Picker view for target language
    @IBOutlet weak var pickerTargetLanguage: UIPickerView!
    //Button to process translation
    @IBOutlet weak var tranlationRequestButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func tappedButtonTranslate(_ sender: Any) {
        processTranslation()
    }
    
    // Used to hide keyboard when there is a user gesture
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textViewLocalText.resignFirstResponder()
    }
    
    // MARK: - Functions
    /// Process translation using translationService core
    private func processTranslation(){
        translationCore.translateText(text: textViewLocalText.text, from: "FR", to: selectedTargetLanguageKey) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.textViewForeignText.text = data.translations[0].text
                case .failure(let error):
                    var additionalAlertAction: [UIAlertAction]?
                    if error == .corruptData || error == .jsonInvalid || error == .unexpectedResponse {
                        let openSettingsAction = UIAlertAction(title: "Open Wi-Fi settings", style: .default) { actionTonOpen in
                            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                        additionalAlertAction = [openSettingsAction]
                    }
                    
                    self?.displayAnAlert(title: "Error", message: "Fail to process.\n\(error.description)", actions: additionalAlertAction)
                }
            }
        }
    }
}

// MARK: - Extensions - PickerView
//Extensions related to the PickerView feature
extension TranslationViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableLanguages.count
    }
}

extension TranslationViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(availableLanguages)[row].value
    }
}


// MARK: - Extensions - Keyboard
//Extensions related to the iOS keyboard
extension TranslationViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textField: UITextView) -> Bool {
        textViewLocalText.resignFirstResponder()
        processTranslation()
        return true
    }
    
}
