//
//  ViewController.swift
//  Frangky_Fnu_Lab05
//
//  Created by Fnu Frangky on 11/25/17.
//  iOS Programming lab 5
//  TUID: tug37915
//  Purpose: iOS UI Practice
//  Copyright © 2017 Fnu Frangky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // player score
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    
    // dice images
    @IBOutlet weak var diceImage: UIImageView!
    
    //game status label
    @IBOutlet weak var gameStatus: UILabel!

    // buttons
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var holdButton: UIButton!
    
    // progress view
    @IBOutlet weak var player1ProgressBar: UIProgressView!
    @IBOutlet weak var player2ProgressBar: UIProgressView!
    
    
    // player score
    var p1Score :Int = 0
    var p2Score :Int = 0
    var dummyscore :Int = 0
    
    // random die
    var dice :Int = 0
    
    // player turn
    var player :Int = 0
    
    // player turn
    var playerOrder = 1
    var whoGoesFirst = 1
    
    var gameInProgress :Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // disable roll and hold button on load
        rollButton.isEnabled = false
        holdButton.isEnabled = false
        player1ProgressBar.progress = 0
        player2ProgressBar.progress = 0
        
        
    }

    @IBAction func newGameClicked(_ sender: UIButton) {
        // if new game is clicked for the first time
        if !gameInProgress {
            continueButton.isEnabled = false
            rollButton.isEnabled = true
            holdButton.isEnabled = false
            continueButton.setTitle("Tap to Continue", for: UIControlState.normal)
            if whoGoesFirst%2 != 0{
                gameStatus.text = "Player 1's turn. Tap roll to begin"
            } else {
                gameStatus.text = "Player 2's turn. Tap roll to begin"
            }
            // which player goes first depends on who starts first
            playerOrder = whoGoesFirst
            player1score.text = String("0")
            player2score.text = String("0")
            p1Score = 0
            p2Score = 0
            gameInProgress = true
            
        } else {
            // tap to continue button
            continueButton.isEnabled = false
            rollButton.isEnabled = true
            holdButton.isEnabled = false
        } 
    }
    
    @IBAction func rollTheDice(_ sender: UIButton) {
        // player 1
        if playerOrder%2 != 0 {
            var dice = Int(arc4random_uniform(6) + 1)
            print("player 1 Roll is pressed")
            diceImage.image = UIImage(named: "\(dice).png")
            // if player 1 rolls 1
            if dice == 1 {
                gameStatus.text = "Player 1 rolled 1. Now player 2's turn"
                rollButton.isEnabled = false
                holdButton.isEnabled = false
                continueButton.isEnabled = true
                playerOrder += 1
                p1Score = p1Score - dummyscore
                dummyscore = 0
                holdButton.isEnabled = false
                player1score.text = String(p1Score)
                player1ProgressBar.setProgress((Float(p1Score))/100, animated: true)
            }
            // if player 1 rolls 2-6
            else {
                p1Score += dice
                dummyscore += dice
                gameStatus.text = "Turns total: \(dummyscore)"
                print(p1Score)
                holdButton.isEnabled = true
            }
            // player 1 win condition
            if p1Score >= 100 {
                player1score.text = String("100")
                player1ProgressBar.setProgress((Float(p1Score))/100, animated: true)
                gameStatus.text = "Congratulations! Player 1 wins"
                //switch which player goes first after new game
                whoGoesFirst += 1
                resetGame()
            }
        // player 2
        } else {
            var dice = Int(arc4random_uniform(6) + 1)
            print("player 2 Roll is pressed")
            diceImage.image = UIImage(named: "\(dice).png")
            // if player 2 rolls 1
            if dice == 1 {
                gameStatus.text = "Player 2 rolled 1. Now player 1's turn"
                rollButton.isEnabled = false
                holdButton.isEnabled = false
                continueButton.isEnabled = true
                playerOrder += 1
                p2Score = p2Score - dummyscore
                dummyscore = 0
                holdButton.isEnabled = false
                player2score.text = String(p2Score)
                player2ProgressBar.setProgress((Float(p2Score))/100, animated: true)
            }
            //if player 2 rolls 2-6
            else {
                p2Score += dice
                dummyscore += dice
                gameStatus.text = "Turns total: \(dummyscore)"
                print(p2Score)
                holdButton.isEnabled = true
            }
            // player 2 win condition
            if p2Score >= 100 {
                player2score.text = String("100")
                player2ProgressBar.setProgress((Float(p2Score))/100, animated: true)
                gameStatus.text = "Congratulations Player 2 wins"
                //switch which player goes first after new game
                whoGoesFirst += 1
                resetGame()
            }
        }
    }
    
    // switch player when hold button is pressed
    @IBAction func HoldPressed(_ sender: UIButton) {
        playerOrder += 1
        holdButton.isEnabled = false
        // player 1 presses hold
        if playerOrder%2 != 0 {
            player2score.text = String(p2Score)
            player2ProgressBar.setProgress((Float(p2Score))/100, animated: true)
            gameStatus.text = "\(dummyscore) points scored!. Now is Player 1's turn"
            dummyscore = 0
            holdButton.isEnabled = false
            rollButton.isEnabled = false
            continueButton.isEnabled = true
        // player 2 presses hold
        } else {
            player1score.text = String(p1Score)
            player1ProgressBar.setProgress((Float(p1Score))/100, animated: true)
            gameStatus.text = "\(dummyscore) points scored!. Now is Player 2's turn"
            dummyscore = 0
            holdButton.isEnabled = false
            rollButton.isEnabled = false
            continueButton.isEnabled = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetGame() {
        continueButton.setTitle("New Game", for: UIControlState.normal)
        gameInProgress = false
        dummyscore = 0
        player1ProgressBar.progress = 0
        player2ProgressBar.progress = 0
        continueButton.isEnabled = true
        rollButton.isEnabled = false
        holdButton.isEnabled = false
    }

    
}

