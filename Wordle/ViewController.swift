//
//  ViewController.swift
//  Wordle
//
//  Created by Erman Ufuk Demirci on 27.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()

    let answers = ["after", "later", "block", "bonus", "craft", "power", "games"]
    var answer = ""
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil,count: 5),count: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answer = answers.randomElement()!
        view.backgroundColor = .systemGray6
        addChildren()
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.datasource = self
        view.addSubview(boardVC.view)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.topAnchor.constraint(equalTo: boardVC.view.bottomAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

extension ViewController: KeyboradViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            
            if stop {
                break
            }
        }
        boardVC.reloadData()
    }
}

extension ViewController: BoardViewControllerDatasoure {
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap({ $0 }).count
        
        guard count == 5 else {
            return nil
        }
        
        let indexedAnswer = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return nil
        }

        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }

        return .systemOrange
    }
    
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    
}
