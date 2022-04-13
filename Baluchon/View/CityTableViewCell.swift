//
//  CityTableViewCell.swift
//  Baluchon
//
//  Created by Clément Garcia on 05/04/2022.
//
import UIKit

// The CityTableViewCell cell represent a custom cell used within the TableView for the WeatherViewController
final class CityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBOutlet
    //Name of the affected city
    @IBOutlet weak var labelCityName: UILabel!
    //Current condition of the affected city
    @IBOutlet weak var labelCityWeather: UILabel!
    //Temperature information of the affected city
    @IBOutlet weak var labelCityTemp: UILabel!
    //View including the label information for the affected city
    @IBOutlet weak var stackViewLabels: UIStackView!
    
    // MARK: - Function
    /// Configure the cell based on the information provided
    /// - Parameters:
    ///   - cityName: Name of the affected city
    ///   - condition: Affected city condition
    ///   - temp: Affected city tempersatures
    func configure(for cityName: String, condition: String, temp: String) {
        labelCityName.text = cityName
        labelCityWeather.text = condition
        labelCityTemp.text = temp
    }
}
