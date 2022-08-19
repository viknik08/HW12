//
//  WorkTimerViewController.swift
//  HW12
//
//  Created by Виктор Басиев on 19.08.2022.
//

import UIKit

class WorkTimerViewController: UIViewController {
//MARK: - Outlets
    private let timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
    var shapeLayer = CAShapeLayer()
    
//MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationProgressBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraint()
    }
    
//MARK: - Setup
    private func setViews() {
        view.backgroundColor = .white
        timerLabel.text = "\(workTime)"
        view.addSubview(timerView)
        timerView.addSubview(timerLabel)
        timerView.addSubview(timerButton)
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
                workTime = 10
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
    
//MARK: - Animation
    
    private func animationProgressBar() {
        
        let center = CGPoint(x: timerView.frame.width / 2, y: timerView.frame.height / 2)
        let end = (-CGFloat.pi / 2)
        let start = 2 * CGFloat.pi + end
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 138,
                                        startAngle: start,
                                        endAngle: end,
                                        clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 13
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.red.cgColor
        timerView.layer.addSublayer(shapeLayer)
    }

}
//MARK: - Constraints
extension WorkTimerViewController {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerView.heightAnchor.constraint(equalToConstant: 300),
            timerView.widthAnchor.constraint(equalToConstant: 300),
            
            timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            
            timerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            timerButton.centerXAnchor.constraint(equalTo: timerView.centerXAnchor)
        ])
    }
}



