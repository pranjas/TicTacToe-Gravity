//
//  ViewController.swift
//  TicTacToe-Gravity
//
//  Created by Jasleen Arora Srivastava on 02/11/18.
//  Copyright © 2018 Jasleen Arora Srivastava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let emojiX = "❌"
    let emojiO = "⭕️"
    var toogleEmoji = true
    
    private var indexTag = 0

    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        if game.isGameOver {
            if !resetButton.isEnabled{
                resetButton.isEnabled = true
                resetButton.setTitle("Reset Game", for: .normal)
            }
            return
        }
        
        if sender.title(for: .normal) == ""{
            let currentEmoji = toogleEmoji ?emojiX: emojiO
            sender.setTitle(currentEmoji, for: .normal)
            toogleEmoji = !toogleEmoji
            sender.backgroundColor = .orange
            let row = sender.tag / rows
            let col = sender.tag % cols
            
            game.setCardIdentifierAt(row, col, identifier: currentEmoji)
            resetButton.setTitle("Board is full", for: .normal)
        }
    }
    
    var allButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addAllButtons(numRows: rows)
        resetButton.isEnabled = false
        resetButton.setTitle("", for: .normal)
        
    }
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func onResetClick(_ sender: UIButton) {
        game.resetBoard()
        for btn in allButtons {
            btn.setTitle("", for: .normal)
        }
        resetButton.isEnabled = false
        resetButton.setTitle("", for: .normal)
    }
    let rows = 3
    let cols = 3
    lazy var game = TicTacToe(rows: rows)

    //TODO: Fix the vertical sizing of the grid, still not coming
    private func addButtonRow(numButtons: Int){
        let horizStackView = UIStackView()
        horizStackView.alignment = .fill
        horizStackView.distribution = .equalSpacing
        horizStackView.axis = .horizontal
        horizStackView.spacing = 5.0
        
        for _ in 0..<numButtons {
            let btn = UIButton()
            btn.setTitle("", for: .normal)
            btn.backgroundColor = .orange
            horizStackView.addArrangedSubview(btn)
            btn.addTarget(self, action: #selector(onButtonClick(_:)), for: .touchUpInside)
            btn.tag = indexTag
            indexTag += 1
            allButtons.append(btn)
        }
        
        mainStackView.addArrangedSubview(horizStackView)
    }
    private func addAllButtons(numRows :Int) {
        for _ in 0..<numRows {
        addButtonRow(numButtons: numRows)
        }
    }
}

