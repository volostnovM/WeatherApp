//
//  SettingViewController.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let saveCompletion: () -> Void
    
    private let firstCloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud_1")?.alpha(0.3)
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let secondCloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud_2")
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let thirdCloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud_3")
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let contentView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(named: "myWhite")
        someView.layer.cornerRadius = 10
        someView.toAutoLayout()
        return someView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor =  UIColor(named: "myBlack")
        label.toAutoLayout()
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        label.toAutoLayout()
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "Скорость ветра"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        label.toAutoLayout()
        return label
    }()
    
    private let dateFormatLabel: UILabel = {
        let label = UILabel()
        label.text = "Формат времени"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        label.toAutoLayout()
        return label
    }()
    
    private let notificationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомления"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        label.toAutoLayout()
        return label
    }()
    
    private let setPreferencesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Установить", for: .normal)
        button.backgroundColor = UIColor(named: "myOrange")
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.setTitleColor(UIColor(named: "myWhite"), for: .normal)
        button.layer.cornerRadius = 10
        button.toAutoLayout()
        return button
    }()
    
    private let temperatureSegmentedControl: UISegmentedControl = {
        let items = ["C", "F"]
        let control = UISegmentedControl(items: items)
        if UserDefaults.standard.string(forKey: "temperature") == "C" {
            control.selectedSegmentIndex = 0
        } else {
            control.selectedSegmentIndex = 1
        }
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        control.toAutoLayout()
        return control
    }()
    
    private let windSpeedSegmentedControl: UISegmentedControl = {
        let items = ["Mi", "Km"]
        let control = UISegmentedControl(items: items)
        if UserDefaults.standard.string(forKey: "windSpeed") == "Mi" {
            control.selectedSegmentIndex = 0
        } else {
            control.selectedSegmentIndex = 1
        }
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        control.toAutoLayout()
        return control
    }()
    
    private let dateFormatSegmentedControl: UISegmentedControl = {
        let items = ["12", "24"]
        let control = UISegmentedControl(items: items)
        if UserDefaults.standard.string(forKey: "dateFormat") == "12" {
            control.selectedSegmentIndex = 0
        } else {
            control.selectedSegmentIndex = 1
        }
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        control.toAutoLayout()
        return control
    }()
    
    private let notificationsSegmentedControl: UISegmentedControl = {
        let items = ["On", "Off"]
        let control = UISegmentedControl(items: items)
        if UserDefaults.standard.string(forKey: "notifications") == "On" {
            control.selectedSegmentIndex = 0
        } else {
            control.selectedSegmentIndex = 1
        }
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        control.toAutoLayout()
        return control
    }()
    
    // MARK: -INIT
    init(saveComletion: @escaping () -> Void) {
        self.saveCompletion = saveComletion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBlue")
        setupViews()
        setTargetForButton()
    }
    
    private func setTargetForButton() {
        setPreferencesButton.addTarget(self, action: #selector(setPreferencesButtonTapped), for: .touchUpInside)
    }
    
    @objc private func setPreferencesButtonTapped() {
        if temperatureSegmentedControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.setValue("C", forKey: "temperature")
        } else {
            UserDefaults.standard.setValue("F", forKey: "temperature")
        }
        if windSpeedSegmentedControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.setValue("Mi", forKey: "windSpeed")
        } else {
            UserDefaults.standard.setValue("Km", forKey: "windSpeed")
        }
        if dateFormatSegmentedControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.setValue("12", forKey: "dateFormat")
        } else {
            UserDefaults.standard.setValue("24", forKey: "dateFormat")
        }
        if notificationsSegmentedControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.setValue(true, forKey: "notifications")
        } else {
            UserDefaults.standard.setValue(false, forKey: "notifications")
        }
        saveCompletion()
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController {
    private func setupViews() {
        
        view.addSubview(firstCloudImageView)
        view.addSubview(secondCloudImageView)
        view.addSubview(thirdCloudImageView)
        view.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(dateFormatLabel)
        contentView.addSubview(notificationsLabel)
        contentView.addSubview(setPreferencesButton)
        contentView.addSubview(temperatureSegmentedControl)
        contentView.addSubview(windSpeedSegmentedControl)
        contentView.addSubview(dateFormatSegmentedControl)
        contentView.addSubview(notificationsSegmentedControl)
        
        [
            firstCloudImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 37),
            firstCloudImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstCloudImageView.heightAnchor.constraint(equalToConstant: 58),
            
            secondCloudImageView.topAnchor.constraint(equalTo: firstCloudImageView.bottomAnchor, constant: 26),
            secondCloudImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondCloudImageView.heightAnchor.constraint(equalToConstant: 94),
            
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 330),
            contentView.widthAnchor.constraint(equalToConstant: 320),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            windSpeedLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 30),
            windSpeedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dateFormatLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 30),
            dateFormatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            notificationsLabel.topAnchor.constraint(equalTo: dateFormatLabel.bottomAnchor, constant: 30),
            notificationsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            setPreferencesButton.topAnchor.constraint(equalTo: notificationsLabel.bottomAnchor, constant: 42),
            setPreferencesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            setPreferencesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            setPreferencesButton.heightAnchor.constraint(equalToConstant: 40),
            
            temperatureSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            temperatureSegmentedControl.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            temperatureSegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            temperatureSegmentedControl.widthAnchor.constraint(equalToConstant: 80),
            
            windSpeedSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            windSpeedSegmentedControl.centerYAnchor.constraint(equalTo: windSpeedLabel.centerYAnchor),
            windSpeedSegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            windSpeedSegmentedControl.widthAnchor.constraint(equalToConstant: 80),
            
            dateFormatSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            dateFormatSegmentedControl.centerYAnchor.constraint(equalTo: dateFormatLabel.centerYAnchor),
            dateFormatSegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            dateFormatSegmentedControl.widthAnchor.constraint(equalToConstant: 80),
            
            notificationsSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            notificationsSegmentedControl.centerYAnchor.constraint(equalTo: notificationsLabel.centerYAnchor),
            notificationsSegmentedControl.heightAnchor.constraint(equalToConstant: 30),
            notificationsSegmentedControl.widthAnchor.constraint(equalToConstant: 80),
            
            thirdCloudImageView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 81),
            thirdCloudImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        .forEach {$0.isActive = true}
    }
}
