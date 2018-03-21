//
//  ViewController.swift
//  Slider-Game
//
//  Created by Kaio on 1/17/18.
//  Copyright © 2018 Kaio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderVal: UISlider!//value of the slider
    @IBOutlet weak var NumberToMatch: UILabel!//this label shows the rand number to match
    
    @IBOutlet weak var rounds: UILabel!//keeps track of the rounds
    @IBOutlet weak var scoreValue: UILabel!//keep track of score
    
    var randomNumber = 0;//number to be put in the NumberToMatch label for user to match it
    var count: Int = 0;//keeps track of the rounds
    
    //innate function when app launches
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startNewRound()//generates number to match
    }

    //innate function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function will refresh the whole game starting at Round 1
    @IBAction func refresh(_ sender: Any) {
        
        count = 0//reset count (rounds)
        startNewRound()//call function
    }
    
    //generates the random number to match
    func startNewRound(){
        
        //random number
        repeat {
            randomNumber = Int(arc4random_uniform(97) + 2)//nums from 2 to 98
        } while randomNumber == 50
        
        //reset slider value to 50
        sliderVal.value = Float(50)
        
        //call the function below
        updateLabels()
    }
    
    //This function updates the labels Score, round and number to match
    func updateLabels() {
        
        //The number above to match
        NumberToMatch.text = "\(randomNumber)"
        
        //Rounds
        count += 1
        rounds.text = "\(count)"
        
        //Score
        if(count == 1){
            scoreValue.text = String(0)
        }
        
    }
    
    //Action button Hit me! if match, displays a message then generates a new num, keeps track
    //of score and the rounds
    @IBAction func matchNumber(_ sender: Any) {
        
        //inside the statements we call two functions
        //updateScore and alertMessage
        if(Int(NumberToMatch.text!) == Int(sliderVal.value)){
            updateScore(score: 100)
            alertMessage(titleText: "You got it!", messageText: "You scored \(Int(sliderVal.value))")
            print("you got it!")
        }
        else if(abs(Int(sliderVal.value)-Int(NumberToMatch.text!)!) > 5){
            updateScore(score: 100 - abs(Int(sliderVal.value)-Int(NumberToMatch.text!)!))
            alertMessage(titleText: "Not even close!", messageText: "You scored \(Int(sliderVal.value))")
            print("Not even close!")
        }
        else {
            updateScore(score: 100 - abs(Int(sliderVal.value)-Int(NumberToMatch.text!)!))
            alertMessage(titleText: "You almost had it!", messageText: "You scored \(Int(sliderVal.value))")
            print("You almost had it!")
        }
    }
    
    //this func updates the score
    func updateScore(score: Int){
        scoreValue.text = "\(score + Int(scoreValue.text!)!)"
    }
    
    //This function will show the pop up for a match or not a match
    func alertMessage(titleText: String, messageText: String){
        
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.startNewRound()//call to generate new num and update score and rounds
        })
        
        alertController.addAction(action)
     
        self.present(alertController, animated: true, completion: nil)
    }
}

