//
//  CityTableViewCell.swift
//  Baluchon
//
//  Created by Clément Garcia on 05/04/2022.
//

import UIKit

// The CityTableViewCell cell represent a custom cell used within the TableView for the WeatherViewController
class CityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityWeather: UILabel!
    @IBOutlet weak var labelCityTemp: UILabel!
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
