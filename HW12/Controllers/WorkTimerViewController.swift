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
    var isStarted = false
    var isWorkTime = true
    var timer = Timer()
    var workTime = 10
    var freeTime = 5
    
//MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraint()
    }
    
//MARK: - Setup
    private func setViews() {
        view.backgroundColor = .white
        timerLabel.text = "\(workTime)"
        view.addSubview(timerLabel)
        view.addSubview(timerButton)
    }
    

//MARK: - Action
    @objc func timerButtonTapped() {

        if timerButton.currentImage == UIImage(systemName: "play.fill") {
            timerButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        } else {
            timerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer.invalidate()
        }
    }
    @objc func timerAction() {
        
        if isWorkTime {
            workTime -= 1
            timerLabel.text = "\(workTime)"
            if workTime == 0 {
                timer.invalidate()
                timerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                workTime = 6
                timerLabel.text = "\(freeTime)"
                isWorkTime = false
                print(isWorkTime)
            }
        } else {
            freeTime -= 1
            timerLabel.text = "\(freeTime)"
            if freeTime == 0 {
                timer.invalidate()
                timerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                freeTime = 5
                timerLabel.text = "\(workTime)"
                isWorkTime = true
                print(isWorkTime)
            }
        }
    }

}
//MARK: - Constraints
extension WorkTimerViewController {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            timerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}



