//
//  MoreForDaysViewController.swift
//  WeatherApp
//
//  Created by TIS Developer on 26.04.2022.
//

import UIKit
import SnapKit

class MoreForDaysViewController: UIViewController {

    // MARK: - PROPERTIES
    private let dailyData: [DailyData]
    private let coordinator: Coordinator
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTaped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Дневная погода"
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
    
    private let dateCollection: UICollectionView = {
        let celSize = CGSize(width: 100, height: 36)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        layout.itemSize = celSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.toAutoLayout()
        return collectionView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .automatic
        return scrollView
    }()
    
    private let contentScrollView = UIView()
    
    private let dayContentView: DayNightForecastView = {
        let someView = DayNightForecastView(for: .day)
        someView.layer.cornerRadius = 5
        return someView
    }()
    
    private let nightContentView: DayNightForecastView = {
        let someView = DayNightForecastView(for: .night)
        someView.layer.cornerRadius = 5
        return someView
    }()
    
    private let sunMoonView = SunAndMoonView()
    
    // MARK: - INIT
    init(location: String,
         dailyData: [DailyData],
         coordinator: Coordinator) {
        self.dailyData = dailyData
        self.coordinator = coordinator
        self.locationLabel.text = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        dateCollection.delegate = self
        dateCollection.dataSource = self
        dateCollection.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "DateColletionViewCell")
        setupViews()
        let indexPath = dateCollection.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        dateCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        fillSubviews(forecastForOneDay: dailyData[0])
    }
    

    @objc private func backButtonTaped() {
        coordinator.goBack()
    }
    
    private func fillSubviews(forecastForOneDay: DailyData) {
        dayContentView.forecastForOneDay = forecastForOneDay
        nightContentView.forecastForOneDay = forecastForOneDay
        sunMoonView.forecastForOneDay = forecastForOneDay
    }
    
    private func setupViews() {
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(locationLabel)
        view.addSubview(dateCollection)
        view.addSubview(scrollView)

        scrollView.addSubview(contentScrollView)
        contentScrollView.addSubview(dayContentView)
        contentScrollView.addSubview(nightContentView)
        contentScrollView.addSubview(sunMoonView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(84)
            make.left.equalToSuperview().offset(17)
            make.width.height.equalTo(12)
        }
        
        titleLabel.snp.makeConstraints { make  in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(20)
            make.height.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(22)
        }
        
        dateCollection.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(dateCollection.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        dayContentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(341)
        }
        
        nightContentView.snp.makeConstraints { make in
            make.top.equalTo(dayContentView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(341)
        }
        
        sunMoonView.snp.makeConstraints { make in
            make.top.equalTo(nightContentView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(137)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - EXTENTIONS
extension MoreForDaysViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DateCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateColletionViewCell", for: indexPath) as! DateCollectionViewCell
        cell.forecastForOneDay = dailyData[indexPath.item]
        if indexPath.item == 0 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell
        guard let forecastForOneDay = cell.forecastForOneDay else {
            return
        }
        self.fillSubviews(forecastForOneDay: forecastForOneDay)
    }
}
