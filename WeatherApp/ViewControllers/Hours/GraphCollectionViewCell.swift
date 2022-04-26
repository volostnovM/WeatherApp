//
//  GraphCollectionViewCell.swift
//  WeatherApp
//
//  Created by TIS Developer on 25.04.2022.
//

import UIKit

class GraphCollectionViewCell: UICollectionViewCell {
    // MARK: - PROPERTIES
    var forecastForOneHour: HourlyData? {
        didSet {
            fillLabels()
        }
    }
    
    var isFirstCell: Bool = false
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.toAutoLayout()
        return label
    }()
    
    public let temperatureDot: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .white
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let probabilityOfPrecipitation: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.toAutoLayout()
        return label
    }()
    
    private let timeDot: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        someView.toAutoLayout()
        return someView
    }()
    
    private let timeLine: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        someView.toAutoLayout()
        return someView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.toAutoLayout()
        return label
    }()
    
    private let temperatureContentView: UIView = {
        let someView = UIView()
        someView.toAutoLayout()
        return someView
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
        drawDashedLines()
    }
    
    func putDotOfTemperature(minTemperature: Double, maxTemperature: Double) {
        temperatureContentView.addSubview(temperatureDot)
        temperatureContentView.addSubview(temperatureLabel)
        
        guard let hourForecast = forecastForOneHour else {
            return
        }
        let differenceBitweenMaxAndMinTemp = maxTemperature - minTemperature
        let pointsPerDegree = 25 / differenceBitweenMaxAndMinTemp
        let currentTemperatureOffset = Int((maxTemperature - hourForecast.temp) * pointsPerDegree)
        temperatureLabel.text = ConvertService.shared.temperatureUsingSavedSetting(temperature: hourForecast.temp)
        
        temperatureDot.snp.remakeConstraints { make in
            make.top.equalTo(temperatureContentView.snp.top).offset(currentTemperatureOffset)
            make.left.equalToSuperview()
            make.height.width.equalTo(4)
        }
        
        temperatureLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(temperatureDot.snp.top).offset(-2)
            make.left.equalToSuperview()
        }
    }
    
    private func setupViews() {
        contentView.addSubview(temperatureContentView)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(probabilityOfPrecipitation)
        contentView.addSubview(timeDot)
        contentView.addSubview(timeLine)
        contentView.addSubview(timeLabel)
        
        [
            temperatureContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            temperatureContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            temperatureContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            temperatureContentView.heightAnchor.constraint(equalToConstant: 25),
            
            weatherIcon.topAnchor.constraint(equalTo: temperatureContentView.bottomAnchor, constant: 14),
            weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 16),
            weatherIcon.widthAnchor.constraint(equalToConstant: 16),
            
            probabilityOfPrecipitation.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 4),
            probabilityOfPrecipitation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            timeDot.topAnchor.constraint(equalTo: probabilityOfPrecipitation.bottomAnchor, constant: 9),
            timeDot.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeDot.heightAnchor.constraint(equalToConstant: 8),
            timeDot.widthAnchor.constraint(equalToConstant: 4),
            
            timeLine.centerYAnchor.constraint(equalTo: timeDot.centerYAnchor),
            timeLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timeLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            timeLabel.topAnchor.constraint(equalTo: timeDot.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ]
        .forEach {$0.isActive = true}
    }
    
    private func fillLabels() {
        guard let hourForecast = forecastForOneHour else {
            return
        }
        if UserDefaults.standard.string(forKey: "temperature") == "C" {
            temperatureLabel.text = "\(Int(hourForecast.temp))\u{00B0}"
        } else {
            temperatureLabel.text = "\(Int((hourForecast.temp * 9/5) + 32))\u{00B0}"
        }
        weatherIcon.image = UIImage(named: hourForecast.weather.icon)
        probabilityOfPrecipitation.text = "\(Int(hourForecast.pop))%"
        let timeFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: "dateFormat") == "24" {
            timeFormatter.dateFormat = "HH:mm"
        } else {
            timeFormatter.dateFormat = "hh:mm"
        }
        timeLabel.text = timeFormatter.string(from: Date(timeIntervalSince1970: hourForecast.dt))
    }
    
    public func drawDashedLines() {
        if isFirstCell {
            addDashedLine(begin: CGPoint(x: temperatureContentView.frame.minX,
                                         y: temperatureContentView.frame.minY),
                          end: CGPoint(x: temperatureContentView.frame.minX,
                                       y: temperatureContentView.frame.maxY))
        }
        addDashedLine(begin: CGPoint(x: temperatureContentView.frame.minX,
                                     y: temperatureContentView.frame.maxY),
                      end: CGPoint(x: temperatureContentView.frame.maxX,
                                   y: temperatureContentView.frame.maxY))
    }
    
    private func addDashedLine(begin: CGPoint, end: CGPoint) {
        let lineDashPattern: [NSNumber]  = [3,3]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        shapeLayer.lineWidth = 0.3
        shapeLayer.lineDashPattern = lineDashPattern
        
        let path = CGMutablePath()
        path.addLines(between: [begin, end])
        
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
}
