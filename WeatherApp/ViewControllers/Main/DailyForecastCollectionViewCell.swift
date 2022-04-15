//
//  DailyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//

import UIKit

class DailyForecastCollectionViewCell: UICollectionViewCell {
    // MARK: - PROPERTIES
    var dailyForecast: DailyData? {
        didSet {
            fillLabels()
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        label.toAutoLayout()
        return label
    }()
    
    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        label.toAutoLayout()
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    private let minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor.black
        label.toAutoLayout()
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.black
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DailyForecastCollectionViewCell {
    func setupViews() {
        contentView.backgroundColor = UIColor(red: 0.91, green: 0.93, blue: 0.98, alpha: 1.0)
        contentView.layer.cornerRadius = 5
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(minMaxTemperatureLabel)
        contentView.addSubview(chevronImageView)
        
        [
        
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 19),
            
            weatherIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            weatherIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            weatherIconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            weatherIconImageView.widthAnchor.constraint(equalTo: weatherIconImageView.heightAnchor),
            
            humidityLabel.centerYAnchor.constraint(equalTo: weatherIconImageView.centerYAnchor),
            humidityLabel.leadingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor, constant: 5),
            
            weatherDescriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 66),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -72),
            
            minMaxTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minMaxTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 6),
            
        ] .forEach {$0.isActive = true}
    }
    
    private func fillLabels() {
        guard let dailyData = dailyForecast else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        let date = Date(timeIntervalSince1970: dailyData.dt)
        dateLabel.text = formatter.string(from: date)
        weatherIconImageView.image = UIImage(named: dailyData.weather.icon)
        humidityLabel.text = "\(dailyData.humidity)%"
        weatherDescriptionLabel.text = dailyData.weather.weatherDescription.capitalizingFirstLetter()
        let minTemperature = ConvertService.shared.temperatureUsingSavedSetting(temperature: dailyData.temp.min)
        let maxTemperature = ConvertService.shared.temperatureUsingSavedSetting(temperature: dailyData.temp.max)
        minMaxTemperatureLabel.text = minTemperature + "/" + maxTemperature
    }
}
