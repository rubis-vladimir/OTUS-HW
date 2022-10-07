//
//  StopwatchViewController.swift
//  #16 Stopwatch
//
//  Created by Владимир Рубис on 07.10.2022.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    // MARK: - IBOutlets and properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    private var timer: Timer?
    private var isLaunched = false
    private var count = 0
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
    }
    
    // MARK: - IBActions
    @IBAction func startButtonPressed() {
        isLaunched = true
        start()
    }
    
    @IBAction func stopButtonPressed() {
        isLaunched = false
        stop()
    }
    
    @IBAction func resetButtonPressed() {
        isLaunched = false
        reset()
    }
    
    // MARK: - Private func
    /// Настраивает элементы
    private func setupElements() {
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 15
        
        startButton.layer.borderWidth = 4
        stopButton.layer.borderWidth = 4
        setState(false)
        
        NotificationCenter.default.addObserver(self,
                       selector: #selector(startStopTimer),
                       name: Notification.Name("StartStopTimer"),
                       object: nil)
    }
    
    /// Останавливает Timer при переходе в фоновый
    @objc private func startStopTimer() {
        guard isLaunched else { return }
        stopButton.isEnabled ? stop() : start()
    }

    /// Обновляет время на дисплее
    @objc private func updateTime() {
        count += 1
        let timeCount = count / 10
        let time = splitSeconds(timeCount)
        let timeString = makeTimeString(minutes: time.0,
                                        seconds: time.1)
        timeLabel.text = timeString
    }
    
    /// Запускает Timer
    private func start() {
        guard isLaunched else { return }
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil,
            repeats: true)
        
        setState(true)
    }
    
    /// Останавливает Timer
    private func stop() {
        timer?.invalidate()
        setState(false)
    }
    
    /// Сбрасывает Timer на 0
    private func reset() {
        timer?.invalidate()
        count = 0
        timeLabel.text = "00:00"
        setState(false)
    }
    
    /// Устанавливает состояние кнопок
    private func setState(_ state: Bool) {
        if state {
            startButton.isEnabled = false
            startButton.layer.borderColor = UIColor.gray.cgColor
            stopButton.isEnabled = true
            stopButton.layer.borderColor = UIColor.red.cgColor
        } else {
            startButton.isEnabled = true
            startButton.layer.borderColor = UIColor.green.cgColor
            stopButton.isEnabled = false
            stopButton.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    /// Разделяет секунды на минуты и секунды
    private func splitSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    /// Создает строку времени для отображения
    private func makeTimeString(minutes: Int,
                                seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}

