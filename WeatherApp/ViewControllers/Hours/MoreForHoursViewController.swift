//
//  MoreForHoursViewController.swift
//  WeatherApp
//
//  Created by TIS Developer on 25.04.2022.
//

import UIKit

class MoreForHoursViewController: UIViewController {

    // MARK: - PROPERTIES
    private let hourlyData: [HourlyData]
    private let coordinator: Coordinator
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTaped), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.toAutoLayout()
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на 24 часа"
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.toAutoLayout()
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.toAutoLayout()
        return label
    }()
    
    private let hourlyGraphView: HourlyGraphView
    
    private let hourForecastDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.toAutoLayout()
        return tableView
    }()
    

    
    // MARK: - INIT
    init(location: String,
         hourlyData: [HourlyData],
         coordinator: Coordinator) {
        self.hourlyData = hourlyData
        self.coordinator = coordinator
        self.locationLabel.text = location
        self.hourlyGraphView = HourlyGraphView(hourlyData: hourlyData)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        hourForecastDetailsTableView.delegate = self
        hourForecastDetailsTableView.dataSource = self
        hourForecastDetailsTableView.register(HourForecastDetailsTableViewCell.self, forCellReuseIdentifier: "HourForecastDetailsTableViewCell")
        setupViews()
    }
    
    @objc private func backButtonTaped() {
        coordinator.goBack()
    }
    
    func setupViews() {
        hourlyGraphView.toAutoLayout()
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(locationLabel)
        view.addSubview(hourlyGraphView)
        view.addSubview(hourForecastDetailsTableView)
        
        [
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 59),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            locationLabel.heightAnchor.constraint(equalToConstant: 22),
            
            hourlyGraphView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 15),
            hourlyGraphView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourlyGraphView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            hourForecastDetailsTableView.topAnchor.constraint(equalTo: hourlyGraphView.bottomAnchor, constant: 15),
            hourForecastDetailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourForecastDetailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hourForecastDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        .forEach {$0.isActive = true}
    }
}

extension MoreForHoursViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourForecastDetailsTableViewCell") as! HourForecastDetailsTableViewCell
        cell.oneHourData = hourlyData[indexPath.item]
        return cell
    }
}
