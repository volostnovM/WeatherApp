//
//  DayNightForecastView.swift
//  WeatherApp
//
//  Created by TIS Developer on 26.04.2022.
//

import UIKit
import SnapKit

class DayNightForecastView: UIView {

    // MARK: - PROPERTIES
    enum DayOrNight {
        case day
        case night
    }

    var forecastForOneDay: DailyData? {
        didSet {
            fillLabels()
        }
    }
    
    private let dayOrNight: DayOrNight
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 30)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let feelsLikeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "feelsLike")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let feelsLikeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "По ощущениям"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let windTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ветер"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let windSpeedDirectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let uviIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "01d")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let uviTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Уф индекс"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let uviLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let rainIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "09d")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let rainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Дождь"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let rainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let cloudsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "03d")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let cloudsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Облачность"
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let cloudsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let feelsLikeLineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        return someView
    }()
    
    private let windLineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        return someView
    }()
    
    private let uviLineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        return someView
    }()
    
    private let rainLineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        return someView
    }()
    
    private let cloudsLineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        return someView
    }()
    
    // MARK: - INIT
    init(for dayOrNight: DayOrNight) {
        self.dayOrNight = dayOrNight
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0.91, green: 0.93, blue: 0.98, alpha: 1.0)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - FUNCTIONS
    private func fillLabels() {
        guard let forecastData = forecastForOneDay else {
            return
        }
        switch dayOrNight {
        case .day:
            titleLabel.text = "День"
            temperatureLabel.text =
                ConvertService.shared.temperatureUsingSavedSetting(temperature: forecastData.temp.day)
            feelsLikeTemperatureLabel.text =
                ConvertService.shared.temperatureUsingSavedSetting(temperature: forecastData.feelsLike.day)
        case .night:
            titleLabel.text = "Ночь"
            temperatureLabel.text =
                ConvertService.shared.temperatureUsingSavedSetting(temperature: forecastData.temp.night)
            feelsLikeTemperatureLabel.text =
                ConvertService.shared.temperatureUsingSavedSetting(temperature: forecastData.feelsLike.night)
        }
        weatherIcon.image = UIImage(named: forecastData.weather.icon)
        weatherDescriptionLabel.text = forecastData.weather.weatherDescription.capitalizingFirstLetter()
        let windDirection = ConvertService.shared.windDirection(from: Double(forecastData.windDeg))
        let windSpeed = ConvertService.shared.windSpeedUsingSavedSettings(windSpeed: Int16(forecastData.windSpeed))
        windSpeedDirectionLabel.text = windSpeed + " " + windDirection
        uviLabel.text = uviRiskType(uviIndex: Int(forecastData.uvi))
        rainLabel.text = "\(forecastData.humidity)%"
        cloudsLabel.text = "\(forecastData.clouds)%"
    }
    
    private func setupViews() {
        [titleLabel, temperatureLabel, weatherIcon, weatherDescriptionLabel,
         feelsLikeIcon, feelsLikeTitleLabel, feelsLikeTemperatureLabel, feelsLikeLineView,
         windIcon, windTitleLabel, windSpeedDirectionLabel, windLineView,
         uviIcon, uviTitleLabel, uviLabel, uviLineView,
         rainIcon, rainTitleLabel, rainLabel, rainLineView,
         cloudsIcon, cloudsTitleLabel, cloudsLabel, cloudsLineView]
            .forEach {self.addSubview($0)}
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(22)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(36)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(temperatureLabel.snp.height)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(11)
        }
        
        feelsLikeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.left.equalToSuperview().offset(54)
            make.height.equalTo(19)
        }
        
        feelsLikeIcon.snp.makeConstraints { make in
            make.centerY.equalTo(feelsLikeTitleLabel.snp.centerY)
            make.centerX.equalTo(54/2)
            make.width.equalTo(24)
            make.height.equalTo(26)
        }
        
        feelsLikeTemperatureLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(feelsLikeTitleLabel.snp.centerY)
            make.height.equalTo(22)
        }
        
        feelsLikeLineView.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeTitleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        windTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeTitleLabel.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(54)
            make.height.equalTo(19)
        }
        
        windIcon.snp.makeConstraints { make in
            make.centerY.equalTo(windTitleLabel.snp.centerY)
            make.centerX.equalTo(54/2)
            make.width.equalTo(24)
            make.height.equalTo(14)
        }
        
        windSpeedDirectionLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(windTitleLabel.snp.centerY)
            make.height.equalTo(22)
        }
        
        windLineView.snp.makeConstraints { make in
            make.top.equalTo(windTitleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        uviTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(windTitleLabel.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(54)
            make.height.equalTo(19)
        }
        
        uviIcon.snp.makeConstraints { make in
            make.centerY.equalTo(uviTitleLabel.snp.centerY)
            make.centerX.equalTo(54/2)
            make.width.equalTo(24)
            make.height.equalTo(14)
        }
        
        uviLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(uviTitleLabel.snp.centerY)
            make.height.equalTo(22)
        }
        
        uviLineView.snp.makeConstraints { make in
            make.top.equalTo(uviTitleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        rainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(uviTitleLabel.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(54)
            make.height.equalTo(19)
        }
        
        rainIcon.snp.makeConstraints { make in
            make.centerY.equalTo(rainTitleLabel.snp.centerY)
            make.centerX.equalTo(54/2)
            make.width.equalTo(24)
            make.height.equalTo(14)
        }
        
        rainLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(rainTitleLabel.snp.centerY)
            make.height.equalTo(22)
        }
        
        rainLineView.snp.makeConstraints { make in
            make.top.equalTo(rainTitleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        cloudsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(rainTitleLabel.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(54)
            make.height.equalTo(19)
        }
        
        cloudsIcon.snp.makeConstraints { make in
            make.centerY.equalTo(cloudsTitleLabel.snp.centerY)
            make.centerX.equalTo(54/2)
            make.width.equalTo(24)
            make.height.equalTo(14)
        }
        
        cloudsLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(cloudsTitleLabel.snp.centerY)
            make.height.equalTo(22)
        }
        
        cloudsLineView.snp.makeConstraints { make in
            make.top.equalTo(cloudsTitleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
    private func uviRiskType(uviIndex: Int) -> String {
        switch uviIndex {
        case 0...2:
            return "\(uviIndex)(низкий)"
        case 3...5:
            return "\(uviIndex)(умерен.)"
        case 6...7:
            return "\(uviIndex)(высокий)"
        case 8...10:
            return "\(uviIndex)(оч.выс.)"
        default:
            return "\(uviIndex)(чрезмер.)"
        }
    }
}
