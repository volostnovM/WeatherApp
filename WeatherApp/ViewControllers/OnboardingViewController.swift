//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let coordinator: Coordinator
    
    private let onboardingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "umbrella")
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let requestTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Разрешить приложению Weather использовать данные о местоположении вашего устройства"
        label.numberOfLines = 0
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 248/255,
                                  green: 245/255,
                                  blue: 245/255,
                                  alpha: 1.0)
        label.toAutoLayout()
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        label.numberOfLines = 0
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы можете изменить свой выбор в любое время из меню приложения"
        label.numberOfLines = 0
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.backgroundColor = UIColor(named: "myOrange")
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 12)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font =  UIFont(name: "Rubik-Regular", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    // MARK: -INIT
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupViews()
    }
    
    
    @objc private func acceptButtonTapped() {
        FirstStartIndicator.shared.setNotFirstStart()
        LocationManager.shared.startGetLocation { [weak self] in
            self?.coordinator.showMainViewController()
        }
    }
    
    @objc private func cancelButtonTapped() {
        FirstStartIndicator.shared.setNotFirstStart()
        coordinator.showMainViewController()
    }
}

extension OnboardingViewController {
    private func setupViews() {
        view.backgroundColor = UIColor(named: "mainBlue")
        view.addSubview(onboardingImage)
        view.addSubview(requestTitleLabel)
        view.addSubview(infoLabel)
        view.addSubview(additionalInfoLabel)
        view.addSubview(acceptButton)
        view.addSubview(cancelButton)
        
        [
            onboardingImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 63),
            onboardingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingImage.heightAnchor.constraint(equalToConstant: 334),
            onboardingImage.widthAnchor.constraint(equalToConstant: 305),
            
            requestTitleLabel.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: 30),
            requestTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            requestTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            
            infoLabel.topAnchor.constraint(equalTo: requestTitleLabel.bottomAnchor, constant: 30),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            
            additionalInfoLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            additionalInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            
            acceptButton.topAnchor.constraint(equalTo: additionalInfoLabel.bottomAnchor, constant: 40),
            acceptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            acceptButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelButton.topAnchor.constraint(equalTo: acceptButton.bottomAnchor, constant: 25),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
        ]
        .forEach {$0.isActive = true}
    }
}
