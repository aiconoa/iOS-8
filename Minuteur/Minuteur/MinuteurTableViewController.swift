//
//  MinuteurTableViewController.swift
//  Minuteur
//
//  Created by formation on 15/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit
import AVFoundation

class MinuteurTableViewController: UITableViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var minuteurContentView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    var isPlaying = false
    
    lazy var timerLabel = UILabel()
    lazy var playingStartDate = NSDate()

    var remainingTimeInSeconds : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("0396", ofType:".wav")!)
        var error: NSError?
        var audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: &error)
audioPlayer.volume = 0.9
        audioPlayer.numberOfLoops = 1
        if error == nil {
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } else {
            println("erreur \(error)")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(sender: UIButton) {
        isPlaying = !isPlaying
        
        if isPlaying {
            playButton.setTitle("Stop" ,forState: .Normal)
            
            timerLabel.text = "??:??:??"
            timerLabel.textAlignment = .Center
            timerLabel.backgroundColor = UIColor.whiteColor()
            timerLabel.opaque = true
            
            timerLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            minuteurContentView.addSubview(timerLabel)
            
            minuteurContentView.addConstraint(
                NSLayoutConstraint(item: minuteurContentView, attribute: .Top, relatedBy: .Equal,
                    toItem: timerLabel, attribute: .Top, multiplier: 1, constant: 0)
            )
            
            minuteurContentView.addConstraint(
                NSLayoutConstraint(item: minuteurContentView, attribute: .Bottom, relatedBy: .Equal,
                    toItem: timerLabel, attribute: .Bottom, multiplier: 1, constant: 0)
            )
            
            minuteurContentView.addConstraint(
                NSLayoutConstraint(item: minuteurContentView, attribute: .Leading, relatedBy: .Equal,
                    toItem: timerLabel, attribute: .Leading, multiplier: 1, constant: 0)
            )
            
            minuteurContentView.addConstraint(
                NSLayoutConstraint(item: minuteurContentView, attribute: .Trailing, relatedBy: .Equal,
                    toItem: timerLabel, attribute: .Trailing, multiplier: 1, constant: 0)
            )

            playingStartDate = NSDate()
            var timerDate = datePicker.date
            var calendar = NSCalendar.currentCalendar()
            var components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: timerDate)
            remainingTimeInSeconds = Double((components.hour * 60 + components.minute) * 60)
            println("\(remainingTimeInSeconds)")
            
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerUpdate", userInfo: nil, repeats: true)
            
            
        } else {
            playButton.setTitle("Play" ,forState: .Normal)
            minuteurContentView.subviews[1].removeFromSuperview()
        }
    }
    
    
    func timerUpdate() {
        if isPlaying {
            var timeElapsedSincePlay = NSDate().timeIntervalSinceDate(playingStartDate)
            
            var countDown = Int(remainingTimeInSeconds - timeElapsedSincePlay)
            if countDown <= 0 {
                // jouer un son
                var soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("0396", ofType:".wav")!)
                var error: NSError?
                var audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: &error)
                if error != nil {
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } else {
                    println(error)
                }
                // arreter le timer
            }
            
            timerLabel.text = "\(Int(remainingTimeInSeconds - timeElapsedSincePlay))"
        }
    }
    
    @IBAction func unwindToMinuteurAnnuler(segue: UIStoryboardSegue!) {}

    @IBAction func unwindToMinuteurChoisir(segue: UIStoryboardSegue!) {
        let sonnerieController = segue.sourceViewController as SonnerieTableViewController
        println(sonnerieController.sonnerie)
    }

}
