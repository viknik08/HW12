//
//  WorkTimerViewController.swift
//  HW12
//
//  Created by Виктор Басиев on 19.08.2022.
//

import UIKit

final class WorkTimerViewController: UIViewController {
//MARK: - Outlets
    private let timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .red
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let timerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(timerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var isStarted = false
    var isWorkTime = true
    var timer = Timer()
    var workTime = 25
    var freeTime = 10
    var shapeLayer = CAShapeLayer()
    var backShapeLayer = CAShapeLayer()
    
//MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backProgressBar()
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
            if isStarted {
                resumeAnimation()
                timerButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                isStarted = false
            } else {
                basicAnimation()
                timerButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
        } else {
            isStarted = true
            timerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer.invalidate()
            pauseAnimation()
        }
    }
    
    @objc func timerAction() {
        if isWorkTime {
            workTime -= 1
            timerLabel.text = "\(workTime)"
            if workTime == 0 {
                timer.invalidate()
                timerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                workTime = 25
                timerLabel.text = "\(freeTime)"
                timerLabel.textColor = .green
                isWorkTime = false
                print(isWorkTime)
            }
        } else {
            freeTime -= 1
            timerLabel.text = "\(freeTime)"
            if freeTime == 0 {
                timer.invalidate()
                timerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                freeTime = 10
                timerLabel.text = "\(workTime)"
                timerLabel.textColor = .red
                isWorkTime = true
                print(isWorkTime)
            }
        }
    }
    
//MARK: - Animation
    private func backProgressBar() {
        
        let center = CGPoint(x: timerView.frame.width / 2, y: timerView.frame.height / 2)
        let end = (-CGFloat.pi / 2)
        let start = 2 * CGFloat.pi + end
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 138,
                                        startAngle: start,
                                        endAngle: end,
                                        clockwise: false)
        
        backShapeLayer.path = circularPath.cgPath
        backShapeLayer.lineWidth = 15
        backShapeLayer.fillColor = UIColor.clear.cgColor
        backShapeLayer.strokeEnd = 1
        backShapeLayer.lineCap = CAShapeLayerLineCap.round
        backShapeLayer.strokeColor = UIColor.gray.cgColor
        timerView.layer.addSublayer(backShapeLayer)
    }
    
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
        shapeLayer.strokeColor = isWorkTime ? UIColor.red.cgColor : UIColor.green.cgColor
        timerView.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = isWorkTime ? CFTimeInterval(workTime) : CFTimeInterval(freeTime)
        basicAnimation.toValue = 0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    private func pauseAnimation(){
        let pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pausedTime
    }
    
    private func resumeAnimation(){
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1.0
        shapeLayer.timeOffset = 0.0
        shapeLayer.beginTime = 0.0
        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayer.beginTime = timeSincePause
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



