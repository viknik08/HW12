//
//  WorkTimerViewController.swift
//  HW12
//
//  Created by Виктор Басиев on 19.08.2022.
//

import UIKit

class WorkTimerViewController: UIViewController {
//MARK: - Outlets
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let timerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
//MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Setup
    

//MARK: - Action
    @objc func timerButtonTapped() {
        timerButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

    }

}



