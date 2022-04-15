//
//  HourlyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    // MARK: -PROPERTIES
    var hourlyForacast: HourlyData? {
        didSet {
            if let hourly = hourlyForacast {
                timeLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: hourly.dt)
                forecastIconImageView.image = UIImage(named: hourly.weather.icon)
                temperatureLabel.text = ConvertService.shared.temperatureUsingSavedSetting(temperature: hourly.temp)
            }
        }
    }
    
    private var timeSettings: String {
        get {
            return UserDefaults.standard.string(forKey: "dateFormat")!
        }
    }
    
    private let forecastContentVIew: UIView = {
        let someView = UIView()
        someView.layer.cornerRadius = 22
        someView.layer.borderWidth = 0.5
        someView.layer.borderColor = UIColor(red: 171/255,
                                             green: 188/255,
                                             blue: 234/255,
                                             alpha: 1.0).cgColor
        someView.toAutoLayout()
        return someView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor(red: 0.613,
                                  green: 0.592,
                                  blue: 0.592,
                                  alpha: 1.0)
        label.toAutoLayout()
        return label
    }()
    
    private let forecastIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .black
        label.toAutoLayout()
        return label
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

extension HourlyForecastCollectionViewCell {
    private func setupViews() {
        
        contentView.addSubview(forecastContentVIew)
        forecastContentVIew.addSubview(timeLabel)
        forecastContentVIew.addSubview(forecastIconImageView)
        forecastContentVIew.addSubview(temperatureLabel)
        
        [
            forecastContentVIew.topAnchor.constraint(equalTo: self.topAnchor),
            forecastContentVIew.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            forecastContentVIew.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            forecastContentVIew.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            forecastContentVIew.widthAnchor.constraint(equalToConstant: 42),
            forecastContentVIew.heightAnchor.constraint(equalToConstant: 83),
            
            forecastIconImageView.widthAnchor.constraint(equalToConstant: 20),
            forecastIconImageView.heightAnchor.constraint(equalToConstant: 20),
            forecastIconImageView.centerXAnchor.constraint(equalTo: forecastContentVIew.centerXAnchor),
            forecastIconImageView.centerYAnchor.constraint(equalTo: forecastContentVIew.centerYAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: forecastContentVIew.topAnchor, constant: 8),
            timeLabel.heightAnchor.constraint(equalToConstant: 18),
            timeLabel.centerXAnchor.constraint(equalTo: forecastContentVIew.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: forecastIconImageView.bottomAnchor, constant:  5),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 18),
            temperatureLabel.centerXAnchor.constraint(equalTo: forecastContentVIew.centerXAnchor),
            
        ] .forEach{$0.isActive = true}
    }
    
    func showSelected() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 63/255, green: 101/255, blue: 206/255, alpha: 0.58).cgColor,
            UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1).cgColor
        ]
        gradientLayer.frame = self.contentView.bounds
        gradientLayer.cornerRadius = 22
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.shadowColor = UIColor(red: 0.4, green: 0.55, blue: 0.94, alpha: 0.68).cgColor
        self.layer.shadowRadius = 45
        self.layer.shadowOffset = CGSize(width: -5, height: 5)
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        timeLabel.textColor = .white
        temperatureLabel.textColor = .white
    }
}
