//
//  AddNewLocationViewController.swift
//  WeatherApp
//
//  Created by TIS Developer on 14.04.2022.
//

import UIKit

class AddNewLocationViewController: UIViewController {

    // MARK: -PROPERTIES
    private let coordinator: Coordinator
    
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .black
        imageView.toAutoLayout()
        return imageView
    }()
    
    // MARK: -INIT
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
    }
}

extension AddNewLocationViewController {
    private func setupViews() {
        view.addSubview(plusImageView)
        
        [
            plusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusImageView.heightAnchor.constraint(equalToConstant: 100),
            plusImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
            .forEach {$0.isActive = true}
    }
}
