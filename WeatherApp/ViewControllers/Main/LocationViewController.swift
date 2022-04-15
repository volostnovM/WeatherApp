//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by TIS Developer on 15.04.2022.
//

import UIKit

class LocationViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let coordinator: Coordinator
    private let viewModel: LocationOutput
    private var forecast: ForecastData
    private var updatedFlag = false
    
    private var currentForecast: CurrentData? {
        didSet {
            viewModel.getHourlyData(for: forecast) { [weak self] hourlyData in
                self?.hourlyForecast = hourlyData
            }
        }
    }
    private var hourlyForecast: [HourlyData]? {
        didSet {
            viewModel.getDailyData(for: forecast) { [weak self] dailyData in
                self?.dailyForecast = dailyData
            }
        }
    }
    private var dailyForecast: [DailyData]? {
        didSet {
            guard dailyForecast != nil else {
                return
            }
            if !updatedFlag {
                updatedFlag = true
                fillLabels()
                setupViews()
                setupHourlyCollectionView()
                setupDailyColletionView()
                updateForecastData()
            } else {
                fillLabels()
                hourlyForecastColletionView.reloadData()
                dailyForecastColletionView.reloadData()
            }
        }
    }
    
    private var timer = Timer()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location..."
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: "myBlack")
        label.toAutoLayout()
        return label
    }()
    
    private let currentForecastView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(named: "mainBlue")
        someView.layer.cornerRadius = 5
        someView.toAutoLayout()
        return someView
    }()
    
    private let sunEllipseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ellipse")
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let sunriseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunrise")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let sunsetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunset")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--/--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.toAutoLayout()
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 36)
        label.toAutoLayout()
        return label
    }()
    
    private let currentWeatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.toAutoLayout()
        return label
    }()
    
    private let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let rainfallImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "02d")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "humidity")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let rainfallLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.toAutoLayout()
        return label
    }()
    
    private let rainfallWindSpeedHumidityContentView: UIView = {
        let someview = UIView()
        someview.toAutoLayout()
        return someview
    }()
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "myYellow")
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.toAutoLayout()
        return label
    }()
    
    private let moreForDayButton: UIButton = {
        let button = UIButton()
        let atributedString = NSMutableAttributedString(string: "Подробнее на 24 часа")
        atributedString.addAttribute(.underlineStyle,
                                     value: NSNumber(value: 1),
                                     range: NSRange(location: 0, length: atributedString.length))
        atributedString.addAttribute(.font,
                                     value: UIFont(name: "Rubik-Regular", size: 16)!,
                                     range: NSRange(location: 0, length: atributedString.length))
        atributedString.addAttribute(.foregroundColor,
                                     value: UIColor.black,
                                     range: NSRange(location: 0, length: atributedString.length))
        button.setAttributedTitle(atributedString, for: .normal)
        button.addTarget(self, action: #selector(moreForDayButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let hourlyForecastColletionView: UICollectionView = {
        let celSize = CGSize(width: 42, height: 83)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        layout.itemSize = celSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.toAutoLayout()
        return collectionView
    }()
    
    private let dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.text = "Ежедневный прогноз"
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.toAutoLayout()
        return label
    }()
    
    private let dailyForecastColletionView: UICollectionView = {
        let celSize = CGSize(width: UIScreen.main.bounds.width - 16*2, height: 56)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.itemSize = celSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.toAutoLayout()
        return collectionView
    }()
    
    
    // MARK: - INIT
    init(coordinator: Coordinator,
         viewModel: LocationOutput,
         forecast: ForecastData) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)
        self.viewModel.getCurrentData(for: forecast) { [weak self] currentData in
            self?.currentForecast = currentData
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func tick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEEE dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let currentDate = dateFormatter.string(from: Date())
        let currentTime = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: Date().timeIntervalSince1970)
        currentTimeLabel.text = "\(currentTime), \(currentDate)"
    }
    
    @objc private func moreForDayButtonTapped() {
        guard let hourlyData = hourlyForecast else {
            return
        }
    }
    
    private func updateForecastData() {
        viewModel.updateForecast(forecast: forecast) { [weak self] forecastData in
            self?.viewModel.getCurrentData(for: forecastData) { [weak self] currentData in
                self?.currentForecast = currentData
            }
        }
    }

    private func setupHourlyCollectionView() {
        hourlyForecastColletionView.backgroundColor = view.backgroundColor
        hourlyForecastColletionView.delegate = self
        hourlyForecastColletionView.dataSource = self
        hourlyForecastColletionView.register(HourlyForecastCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "HourlyCell")
    }
    
    private func setupDailyColletionView() {
        dailyForecastColletionView.backgroundColor = view.backgroundColor
        dailyForecastColletionView.delegate = self
        dailyForecastColletionView.dataSource = self
        dailyForecastColletionView.register(DailyForecastCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "DailyCell")
    }

}

extension LocationViewController {
    func setupViews() {
        view.addSubview(locationLabel)
        view.addSubview(currentForecastView)
        view.addSubview(moreForDayButton)
        view.addSubview(hourlyForecastColletionView)
        view.addSubview(dailyForecastLabel)
        view.addSubview(dailyForecastColletionView)
        
        currentForecastView.addSubview(sunEllipseImageView)
        currentForecastView.addSubview(minMaxTemperatureLabel)
        currentForecastView.addSubview(currentTemperatureLabel)
        currentForecastView.addSubview(currentWeatherDescriptionLabel)
        currentForecastView.addSubview(sunriseImageView)
        currentForecastView.addSubview(sunriseTimeLabel)
        currentForecastView.addSubview(sunsetImageView)
        currentForecastView.addSubview(sunsetTimeLabel)
        currentForecastView.addSubview(rainfallWindSpeedHumidityContentView)
        currentForecastView.addSubview(currentTimeLabel)
        
        rainfallWindSpeedHumidityContentView.addSubview(rainfallImageView)
        rainfallWindSpeedHumidityContentView.addSubview(rainfallLabel)
        rainfallWindSpeedHumidityContentView.addSubview(windImageView)
        rainfallWindSpeedHumidityContentView.addSubview(windSpeedLabel)
        rainfallWindSpeedHumidityContentView.addSubview(humidityImageView)
        rainfallWindSpeedHumidityContentView.addSubview(humidityLabel)
        
        
        [
            hourlyForecastColletionView.topAnchor.constraint(equalTo: moreForDayButton.bottomAnchor, constant: 10),
            hourlyForecastColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            hourlyForecastColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            hourlyForecastColletionView.heightAnchor.constraint(equalToConstant: 83),
            
            dailyForecastLabel.topAnchor.constraint(equalTo: hourlyForecastColletionView.bottomAnchor, constant: 40),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            dailyForecastColletionView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 10),
            dailyForecastColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dailyForecastColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dailyForecastColletionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 41),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currentForecastView.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            currentForecastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentForecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sunEllipseImageView.topAnchor.constraint(equalTo: currentForecastView.topAnchor, constant: 17),
            sunEllipseImageView.leadingAnchor.constraint(equalTo: currentForecastView.leadingAnchor, constant: 33),
            sunEllipseImageView.trailingAnchor.constraint(equalTo: currentForecastView.trailingAnchor, constant: -31),
            
            sunriseImageView.widthAnchor.constraint(equalTo: sunriseImageView.heightAnchor),
            sunriseImageView.topAnchor.constraint(equalTo: currentForecastView.topAnchor, constant: 145),
            sunriseImageView.leadingAnchor.constraint(equalTo: currentForecastView.leadingAnchor, constant: 25),
            sunriseImageView.bottomAnchor.constraint(equalTo: currentForecastView.bottomAnchor, constant: -50),
            
            sunsetImageView.widthAnchor.constraint(equalTo: sunriseImageView.heightAnchor),
            sunsetImageView.topAnchor.constraint(equalTo: currentForecastView.topAnchor, constant: 145),
            sunsetImageView.trailingAnchor.constraint(equalTo: currentForecastView.trailingAnchor, constant: -25),
            sunsetImageView.bottomAnchor.constraint(equalTo: currentForecastView.bottomAnchor, constant: -50),
            
            sunriseTimeLabel.centerXAnchor.constraint(equalTo: sunriseImageView.centerXAnchor),
            sunriseTimeLabel.bottomAnchor.constraint(equalTo: currentForecastView.bottomAnchor, constant: -26),
            
            sunsetTimeLabel.centerXAnchor.constraint(equalTo: sunsetImageView.centerXAnchor),
            sunsetTimeLabel.bottomAnchor.constraint(equalTo: currentForecastView.bottomAnchor, constant: -26),
            
            minMaxTemperatureLabel.topAnchor.constraint(equalTo: currentForecastView.topAnchor, constant: 33),
            minMaxTemperatureLabel.centerXAnchor.constraint(equalTo: currentForecastView.centerXAnchor),
            minMaxTemperatureLabel.heightAnchor.constraint(equalToConstant: 20),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: minMaxTemperatureLabel.bottomAnchor, constant: 5),
            currentTemperatureLabel.centerXAnchor.constraint(equalTo: currentForecastView.centerXAnchor),
            currentTemperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            
            currentWeatherDescriptionLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 5),
            currentWeatherDescriptionLabel.centerXAnchor.constraint(equalTo: currentForecastView.centerXAnchor),
            currentWeatherDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            rainfallWindSpeedHumidityContentView.topAnchor.constraint(equalTo: currentWeatherDescriptionLabel.bottomAnchor, constant: 8),
            rainfallWindSpeedHumidityContentView.centerXAnchor.constraint(equalTo: currentForecastView.centerXAnchor),
            rainfallWindSpeedHumidityContentView.heightAnchor.constraint(equalToConstant: 30),
            
            rainfallImageView.topAnchor.constraint(equalTo: rainfallWindSpeedHumidityContentView.topAnchor, constant: 8),
            rainfallImageView.leadingAnchor.constraint(equalTo: rainfallWindSpeedHumidityContentView.leadingAnchor),
            rainfallImageView.bottomAnchor.constraint(equalTo: rainfallWindSpeedHumidityContentView.bottomAnchor, constant: -5),
            
            rainfallLabel.centerYAnchor.constraint(equalTo: rainfallImageView.centerYAnchor),
            rainfallLabel.leadingAnchor.constraint(equalTo: rainfallImageView.trailingAnchor, constant: 5),
            
            windImageView.centerYAnchor.constraint(equalTo: rainfallImageView.centerYAnchor),
            windImageView.leadingAnchor.constraint(equalTo: rainfallLabel.trailingAnchor, constant: 20),
            
            windSpeedLabel.centerYAnchor.constraint(equalTo: rainfallImageView.centerYAnchor),
            windSpeedLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 5),
            
            humidityImageView.centerYAnchor.constraint(equalTo: rainfallImageView.centerYAnchor),
            humidityImageView.leadingAnchor.constraint(equalTo: windSpeedLabel.trailingAnchor, constant: 20),
            
            humidityLabel.centerYAnchor.constraint(equalTo: rainfallImageView.centerYAnchor),
            humidityLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 5),
            humidityLabel.trailingAnchor.constraint(equalTo: rainfallWindSpeedHumidityContentView.trailingAnchor),
            
            currentTimeLabel.topAnchor.constraint(equalTo: rainfallWindSpeedHumidityContentView.bottomAnchor, constant: 10),
            currentTimeLabel.bottomAnchor.constraint(equalTo: currentForecastView.bottomAnchor, constant: -21),
            currentTimeLabel.centerXAnchor.constraint(equalTo: currentForecastView.centerXAnchor),
            currentTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            moreForDayButton.topAnchor.constraint(equalTo: currentForecastView.bottomAnchor, constant: 33),
            moreForDayButton.trailingAnchor.constraint(equalTo: currentForecastView.trailingAnchor, constant: -15)
            
        ] .forEach {$0.isActive = true}
    }
    
    
    private func fillLabels() {
        locationLabel.text = forecast.location
        minMaxTemperatureLabel.text = ConvertService.shared.temperatureUsingSavedSetting(temperature: dailyForecast![0].temp.min) + "/" + ConvertService.shared.temperatureUsingSavedSetting(temperature: dailyForecast![0].temp.max)
        sunriseTimeLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: dailyForecast![0].sunrise)
        sunsetTimeLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: dailyForecast![0].sunset)
        humidityLabel.text = "\(dailyForecast![0].humidity)%"
        currentWeatherDescriptionLabel.text = currentForecast!.weather.weatherDescription
        currentWeatherDescriptionLabel.text?.capitalizeFirstLetter()
        currentTemperatureLabel.text = ConvertService.shared.temperatureUsingSavedSetting(temperature: currentForecast!.temp)
        if dailyForecast![0].rain != 0 {
            rainfallLabel.text = "\(dailyForecast![0].rain) мм"
        } else {
            if dailyForecast![0].snow != 0 {
                rainfallLabel.text = "\(dailyForecast![0].snow) мм"
            } else {
                rainfallLabel.text = "0 мм"
            }
        }
        windSpeedLabel.text = ConvertService.shared.windSpeedUsingSavedSettings(windSpeed: currentForecast!.windSpeed)
    }
}

extension LocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hourlyForecastColletionView {
            return hourlyForecast!.count
        } else {
            return dailyForecast!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hourlyForecastColletionView {
            let cell: HourlyForecastCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyForecastCollectionViewCell
            cell.hourlyForacast = hourlyForecast![indexPath.item]
            return cell
        } else {
            let cell: DailyForecastCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCell", for: indexPath) as! DailyForecastCollectionViewCell
            cell.dailyForecast = dailyForecast![indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == hourlyForecastColletionView {
            let cell = collectionView.cellForItem(at: indexPath) as! HourlyForecastCollectionViewCell
            cell.showSelected()
        } else {
            
            //!!! при нажатии открыть контроллер и показать подробнее по дням
        }
    }
}
