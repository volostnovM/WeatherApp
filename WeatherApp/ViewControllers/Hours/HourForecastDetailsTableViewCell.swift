//
//  HourForecastDetailsTableViewCell.swift
//  WeatherApp
//
//  Created by TIS Developer on 25.04.2022.
//

import UIKit

class HourForecastDetailsTableViewCell: UITableViewCell {
    // MARK: - PROPERTIES
    var oneHourData: HourlyData? {
        didSet {
            fillLabels()
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.toAutoLayout()
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.toAutoLayout()
        return label
    }()
    
    private let weatherDescriptionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon_2")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()
    
    private let windSpeedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let windSpeedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Ветер"
        label.toAutoLayout()
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let precipitationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pop")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let precipitationTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Атмосферные осадки"
        label.toAutoLayout()
        return label
    }()
    
    private let precipitationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let cloudsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "03d")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let cloudsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Облачность"
        label.toAutoLayout()
        return label
    }()
    
    private let cloudsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let lineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        someView.toAutoLayout()
        return someView
    }()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func setupSubviews() {
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherDescriptionIcon)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(feelsLikeLabel)
        contentView.addSubview(windSpeedIcon)
        contentView.addSubview(windSpeedTitleLabel)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(precipitationIcon)
        contentView.addSubview(precipitationTitleLabel)
        contentView.addSubview(precipitationLabel)
        contentView.addSubview(cloudsIcon)
        contentView.addSubview(cloudsTitleLabel)
        contentView.addSubview(cloudsLabel)
        contentView.addSubview(lineView)
        

        [
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 19),
            
            temperatureLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 22),
            
            weatherDescriptionIcon.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            weatherDescriptionIcon.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 11),
            weatherDescriptionIcon.heightAnchor.constraint(equalToConstant: 19),
            weatherDescriptionIcon.widthAnchor.constraint(equalToConstant: 19),
            
            feelsLikeLabel.centerYAnchor.constraint(equalTo: weatherDescriptionIcon.centerYAnchor),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: 19),
            
            weatherDescriptionLabel.centerYAnchor.constraint(equalTo: weatherDescriptionIcon.centerYAnchor),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: weatherDescriptionIcon.trailingAnchor, constant: 4),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: feelsLikeLabel.leadingAnchor, constant: -4),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: 19),
            
            windSpeedTitleLabel.heightAnchor.constraint(equalToConstant: 19),
            
            windSpeedIcon.centerYAnchor.constraint(equalTo: windSpeedTitleLabel.centerYAnchor),
            windSpeedIcon.centerXAnchor.constraint(equalTo: weatherDescriptionIcon.centerXAnchor),
            windSpeedIcon.topAnchor.constraint(equalTo: weatherDescriptionIcon.bottomAnchor, constant: 16),
            windSpeedIcon.trailingAnchor.constraint(equalTo: windSpeedTitleLabel.leadingAnchor, constant: -4),
            windSpeedIcon.heightAnchor.constraint(equalToConstant: 19),
            windSpeedIcon.widthAnchor.constraint(equalToConstant: 19),
            
            windSpeedLabel.centerYAnchor.constraint(equalTo: windSpeedTitleLabel.centerYAnchor),
            windSpeedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            windSpeedLabel.heightAnchor.constraint(equalToConstant: 19),
            
            precipitationTitleLabel.heightAnchor.constraint(equalToConstant: 19),
            
            precipitationIcon.topAnchor.constraint(equalTo: windSpeedIcon.bottomAnchor, constant: 16),
            precipitationIcon.centerXAnchor.constraint(equalTo: weatherDescriptionIcon.centerXAnchor),
            precipitationIcon.centerYAnchor.constraint(equalTo: precipitationTitleLabel.centerYAnchor),
            precipitationIcon.trailingAnchor.constraint(equalTo: precipitationTitleLabel.leadingAnchor, constant: -4),
            precipitationIcon.heightAnchor.constraint(equalToConstant: 19),
            precipitationIcon.widthAnchor.constraint(equalToConstant: 19),
            
            precipitationLabel.centerYAnchor.constraint(equalTo: precipitationTitleLabel.centerYAnchor),
            precipitationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            precipitationLabel.heightAnchor.constraint(equalToConstant: 19),
            
            cloudsTitleLabel.heightAnchor.constraint(equalToConstant: 19),
            
            cloudsIcon.topAnchor.constraint(equalTo: precipitationIcon.bottomAnchor, constant: 16),
            cloudsIcon.centerXAnchor.constraint(equalTo: weatherDescriptionIcon.centerXAnchor),
            cloudsIcon.centerYAnchor.constraint(equalTo: cloudsTitleLabel.centerYAnchor),
            cloudsIcon.trailingAnchor.constraint(equalTo: cloudsTitleLabel.leadingAnchor, constant: -4),
            cloudsIcon.heightAnchor.constraint(equalToConstant: 19),
            cloudsIcon.widthAnchor.constraint(equalToConstant: 19),
            
            cloudsLabel.centerYAnchor.constraint(equalTo: cloudsTitleLabel.centerYAnchor),
            cloudsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cloudsLabel.heightAnchor.constraint(equalToConstant: 19),
            
            lineView.topAnchor.constraint(equalTo: cloudsTitleLabel.bottomAnchor, constant: 8),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: feelsLikeLabel.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ]
        .forEach{$0.isActive = true}
    }
    
    private func fillLabels() {
        guard let hourlyData = oneHourData else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE dd/MM"
        formatter.locale = Locale(identifier: "ru_RU")
        let date = Date(timeIntervalSince1970: hourlyData.dt)
        dateLabel.text = formatter.string(from: date)
        timeLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: hourlyData.dt)
        temperatureLabel.text = ConvertService.shared.temperatureUsingSavedSetting(temperature: hourlyData.temp)
        weatherDescriptionLabel.text = hourlyData.weather.weatherDescription.capitalizingFirstLetter()
        feelsLikeLabel.text = "По ощущениям: " + ConvertService.shared.temperatureUsingSavedSetting(temperature: hourlyData.feelsLike)
        let windSpeed: String = ConvertService.shared.windSpeedUsingSavedSettings(windSpeed: Int16(hourlyData.windSpeed))
        let windDirection: String = ConvertService.shared.windDirection(from: Double(hourlyData.windDeg))
        windSpeedLabel.text = windSpeed + " " + windDirection
        precipitationLabel.text = "\(Int(hourlyData.pop))%"
        cloudsLabel.text = "\(hourlyData.clouds)%"
    }
}
