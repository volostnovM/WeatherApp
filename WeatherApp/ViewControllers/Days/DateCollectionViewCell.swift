//
//  DateCollectionViewCell.swift
//  WeatherApp
//
//  Created by TIS Developer on 26.04.2022.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    var forecastForOneDay: DailyData? {
        didSet {
            guard let forecastData = forecastForOneDay else {
                return
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM EEEEEE"
            formatter.locale = Locale(identifier: "ru_RU")
            let date = Date(timeIntervalSince1970: forecastData.dt)
            dateLabel.text = formatter.string(from: date)
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        willSet {
            super.isSelected = newValue
            if newValue {
                self.selectedColorSet()
            } else {
                self.deselectedColorSet()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-7)
        }
    }
    
    func selectedColorSet() {
        contentView.backgroundColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        contentView.layer.cornerRadius = 5
        dateLabel.textColor = .white
    }
    
    func deselectedColorSet() {
        contentView.backgroundColor = .white
        dateLabel.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
    }
}
