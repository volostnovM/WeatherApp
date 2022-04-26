//
//  MainViewController.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let coordinator: Coordinator
    private var viewModel: MainOutput
    private var currentIndex: Int?
    private var pendingIndex: Int?
    private var savedForcasts: [ForecastData]?
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.tintColor = UIColor(named: "myBlack")
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let locationChoiceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.tintColor = UIColor(named: "myBlack")
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let pageControl = UIPageControl()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal,
                                                          options: nil)
    
    private var locationViewControllers: [UIViewController] = []
    
    // MARK: -INIT
    init(coordinator: Coordinator,
         viewModel: MainOutput) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        downloadData()
        setupScreen()
    }
    
    private func setupScreen() {
        guard  let forecastData = savedForcasts else {
            fatalError("MainViewController: savedForecast = nil")
        }

        if forecastData.isEmpty {
            if LocationManager.shared.isEnabled() {
                viewModel.getForecastUsingGeolocation { [weak self] in
                    self?.downloadData()
                    guard let forecast = self?.savedForcasts else {
                        return
                    }
                    guard let locationViewController = self?.coordinator.createLocationViewController(with: forecast[0]) else {
                        return
                    }
                    self?.locationViewControllers.append(locationViewController)
                    self?.setupPageViewController()
                    self?.setupPageControl()
                    self?.setupViews()
                }
            } else {
                let addNewLocationViewController = coordinator.createAddNewLocationViewController()
                locationViewControllers = [addNewLocationViewController]
                setupPageViewController()
                setupPageControl()
                setupViews()
            }
        } else {
            for value in forecastData {
                let locationViewController = coordinator.createLocationViewController(with: value)
                locationViewControllers.append(locationViewController)
            }
            setupPageViewController()
            setupPageControl()
            setupViews()
        }
    }
    
    @objc private func settingButtonTapped() {
        print("settingButtonTapped")
        coordinator.showSettingsScreen(updateCompletion: updatePageViewController)
    }
    
    @objc private func locationButtonTapped() {
        print("locationButtonTapped")
        coordinator.showLocationChoice { [weak self] in
            self?.viewModel.downloadForecastFromDataBase { [weak self] forecastData in
                self?.savedForcasts = forecastData
                self?.updatePageViewController()
            }
        }
    }
    
    private func downloadData() {
        viewModel.downloadForecastFromDataBase { [weak self] forecastData in
            self?.savedForcasts = forecastData
        }
    }
}

extension MainViewController {
    private func setupViews() {
        pageControl.toAutoLayout()
        pageViewController.view.toAutoLayout()
        
        pageViewController.view.addSubview(settingsButton)
        pageViewController.view.addSubview(locationChoiceButton)
        view.addSubview(pageViewController.view)
        view.addSubview(pageControl)
        
        [
            //pageViewController.view.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            settingsButton.topAnchor.constraint(equalTo: pageViewController.view.topAnchor, constant: 43),
            settingsButton.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor, constant: 16),
            settingsButton.heightAnchor.constraint(equalToConstant: 18),
            settingsButton.widthAnchor.constraint(equalToConstant: 34),
            
            locationChoiceButton.topAnchor.constraint(equalTo: pageViewController.view.topAnchor, constant: 37),
            locationChoiceButton.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor, constant: -15),
            locationChoiceButton.heightAnchor.constraint(equalToConstant: 26),
            locationChoiceButton.widthAnchor.constraint(equalToConstant: 20),
            
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 82),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        .forEach {$0.isActive = true}
    }
    
    private func setupPageViewController() {
        guard let first = locationViewControllers.first else {
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([first],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = locationViewControllers.count
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .black
    }
    
    private func updatePageViewController() {
        locationViewControllers = []
        guard let forecastData = savedForcasts else {
            return
        }
        for value in forecastData {
            let locationViewController = coordinator.createLocationViewController(with: value)
            locationViewControllers.append(locationViewController)
        }
        guard let last = locationViewControllers.last else {
            return
        }
        pageViewController.setViewControllers([last],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        pageControl.numberOfPages = locationViewControllers.count
        pageControl.currentPage = pageControl.numberOfPages - 1
    }
}

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = locationViewControllers.firstIndex(of: viewController),
              index > 0 else {
            return nil
        }
        let before = index - 1
        return locationViewControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = locationViewControllers.firstIndex(of: viewController),
              index < (locationViewControllers.count - 1) else {
            return nil
        }
        let after = index + 1
        return locationViewControllers[after]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = locationViewControllers.firstIndex(of: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
}

