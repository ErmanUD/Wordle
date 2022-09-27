//
//  KeyboardViewController.swift
//  Wordle
//
//  Created by Erman Ufuk Demirci on 27.09.2022.
//

import UIKit

class KeyboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var keys: [[Character]] = [["q","w","e","r","t","y","u","i","o","p"],
                                       ["a","s","d","f","g","h","j","k","l"],
                                       ["z","x","c","v","b","n","m"]
    ]
    
    private let keyboardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardCollectionView.delegate = self
        keyboardCollectionView.dataSource = self
        view.addSubview(keyboardCollectionView)
        keyboardConstraints()
    }
    
    private func keyboardConstraints() {
        NSLayoutConstraint.activate([
            keyboardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            keyboardCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    


}

extension KeyboardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
            fatalError()
        }
        let letter = keys[indexPath.section][indexPath.row]
        cell.configure(with: letter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width - margin)/10
        
        return CGSize(width: size, height: size * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width - margin)/10

        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))
        let inset: CGFloat = (collectionView.frame.size.width - (size*count) - 2*count)/2
        
        let left: CGFloat = inset
        let right: CGFloat = inset

        return UIEdgeInsets(top: 2,
                            left: left,
                            bottom: 2,
                            right: right)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
