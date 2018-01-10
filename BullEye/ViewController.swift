//
//  ViewController.swift
//  BullEye
//
//  Created by 景 王 on 2018-01-09.
//  Copyright © 2018 景 王. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var currentValue: Int = 50
    var targetValue: Int = 0
    var roundNum: Int = 0
    var score: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startOver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(){
        let message = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)"
        
        let alert = UIAlertController(title: "Hello, World",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        let difference = abs(currentValue - targetValue)
        score = score + 100 - difference
        
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        // print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    

    
    @IBAction func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value=Float(currentValue)
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)

    }
    
    @IBAction func startOver() {
        roundNum = roundNum + 1
        roundLabel.text=String(roundNum)
        score = 0
        scoreLabel.text=String(score)
        startNewRound()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
}

