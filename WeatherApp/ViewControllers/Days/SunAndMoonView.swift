//
//  SunAndMoonView.swift
//  WeatherApp
//
//  Created by TIS Developer on 26.04.2022.
//

import UIKit

class SunAndMoonView: UIView {

    // MARK: - PROPERTIES
    
    var forecastForOneDay: DailyData? {
        didSet {
            fillLabels()
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.text = "Солнце и Луна"
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let moonPhaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "moon")
        return imageView
    }()
    
    private let moonPhaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let sunIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "01d")
        return imageView
    }()
    
    private let moonIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "moon_2")
        return imageView
    }()
    
    private let sunDurationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let moonDurationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let sunriseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        label.text = "Восход"
        return label
    }()
    
    private let sunsetTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        label.text = "Заход"
        return label
    }()
    
    private let sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let moonriseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        label.text = "Восход"
        return label
    }()
    
    private let moonsetTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        label.text = "Заход"
        return label
    }()
    
    private let moonriseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let moonsetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        return label
    }()
    
    private let verticalLine: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        return someView
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
        drawDashedLines()
    }
    
    private func setupSubviews() {
        
        self.addSubview(titleLabel)
        self.addSubview(moonPhaseImageView)
        self.addSubview(moonPhaseLabel)
        self.addSubview(sunIcon)
        self.addSubview(moonIcon)
        self.addSubview(sunDurationLabel)
        self.addSubview(moonDurationLabel)
        self.addSubview(sunriseTitleLabel)
        self.addSubview(sunsetTitleLabel)
        self.addSubview(sunriseLabel)
        self.addSubview(sunriseLabel)
        self.addSubview(sunsetLabel)
        self.addSubview(moonriseTitleLabel)
        self.addSubview(moonsetTitleLabel)
        self.addSubview(moonriseLabel)
        self.addSubview(moonsetLabel)
        self.addSubview(verticalLine)
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(22)
        }
        
        moonPhaseLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(19)
        }
        
        moonPhaseImageView.snp.makeConstraints { make in
            make.centerY.equalTo(moonPhaseLabel)
            make.right.equalTo(moonPhaseLabel.snp.left).offset(-5)
            make.height.width.equalTo(15)
        }
        
        sunIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.height.width.equalTo(20)
        }
        
        sunDurationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sunIcon)
            make.right.equalTo(self.snp.centerX).offset(-17)
            make.height.equalTo(20)
        }
        
        sunriseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sunIcon.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(20)
        }
        
        sunsetTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sunriseTitleLabel.snp.bottom).offset(17)
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(20)
        }
        
        sunriseLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sunriseTitleLabel)
            make.right.equalTo(self.snp.centerX).offset(-17)
            make.height.equalTo(20)
        }
        
        sunsetLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sunsetTitleLabel)
            make.right.equalTo(self.snp.centerX).offset(-17)
            make.height.equalTo(20)
        }
        
        verticalLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(0.5)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
        
        moonIcon.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(sunIcon)
            make.left.equalTo(self.snp.centerX).offset(17)
        }
        
        moonDurationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(moonIcon)
            make.right.equalToSuperview().offset(-5)
        }
        
        moonriseTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.centerX).offset(17)
            make.centerY.equalTo(sunriseTitleLabel)
            make.height.equalTo(20)
        }
        
        moonsetTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.centerX).offset(17)
            make.centerY.equalTo(sunsetTitleLabel)
            make.height.equalTo(20)
        }
        
        moonriseLabel.snp.makeConstraints { make in
            make.centerY.equalTo(moonriseTitleLabel)
            make.right.equalToSuperview().offset(-5)
        }
        
        moonsetLabel.snp.makeConstraints { make in
            make.centerY.equalTo(moonsetTitleLabel)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
    
    private func fillLabels() {
        guard let forecast = forecastForOneDay else {
            return
        }
        moonPhaseLabel.text = moonPhaseInText(moonPhaseInDouble: forecast.moonPhase)
        sunDurationLabel.text = convertFromSecondsToHoursAndMinutes(seconds: Int(forecast.sunset - forecast.sunrise))
        moonDurationLabel.text = calculateMoonDuration(moonrise: forecast.moonrise, moonset: forecast.moonset)
        sunriseLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: forecast.sunrise)
        sunsetLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: forecast.sunset)
        moonriseLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: forecast.moonrise)
        moonsetLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: forecast.moonset)
    }
    
    private func moonPhaseInText(moonPhaseInDouble: Double) -> String {
        switch moonPhaseInDouble {
        case 0, 1:
            return "Новолуние"
        case 0 ..< 0.25:
            return "Молодая Луна"
        case 0.25:
            return "Первая четверть Луны"
        case 0.25 ..< 0.5:
            return "Прибывающая Луна"
        case 0.5:
            return "Полнолуние"
        case 0.5 ..< 0.75:
            return "Убывающая Луна"
        case 0.75:
            return "Последняя четверть Луны"
        case 0.75 ..< 1:
            return "Старая Луна"
        default:
            return "Неизвестно"
        }
    }
    
    private func calculateMoonDuration(moonrise: Double, moonset: Double) -> String {
        var duration: String = ""
        var durationInSeconds: Double
        if moonrise > moonset {
            durationInSeconds = (24 * 3600) - (moonrise - moonset)
        } else {
            durationInSeconds = moonset - moonrise
        }
        duration = convertFromSecondsToHoursAndMinutes(seconds: Int(durationInSeconds))
        return duration
    }
    
    private func convertFromSecondsToHoursAndMinutes(seconds: Int) -> String {
        let hours: Int = seconds/3600
        let minutes: Int = (seconds % 3600) / 60
        return "\(hours)ч \(minutes)мин"
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
    
    func drawDashedLines() {
        addDashedLine(begin: CGPoint(x: 0, y: sunriseTitleLabel.frame.minY - 8),
                      end: CGPoint(x: (self.frame.size.width / 2) - 12, y: sunriseTitleLabel.frame.minY - 8))
        addDashedLine(begin: CGPoint(x: 0, y: sunriseTitleLabel.frame.maxY + 8),
                      end: CGPoint(x: (self.frame.size.width / 2) - 12, y: sunriseTitleLabel.frame.maxY + 8))
        addDashedLine(begin: CGPoint(x: (self.frame.size.width / 2) + 12, y: sunriseTitleLabel.frame.minY - 8),
                      end: CGPoint(x: self.frame.width, y: sunriseTitleLabel.frame.minY - 8))
        addDashedLine(begin: CGPoint(x: (self.frame.size.width / 2) + 12, y: sunriseTitleLabel.frame.maxY + 8),
                      end: CGPoint(x: self.frame.width, y: sunriseTitleLabel.frame.maxY + 8))
    }

}
