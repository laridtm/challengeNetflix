//
//  ViewController.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var propCollectionView: UICollectionView {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let width = view.frame.size.width / 2
//        layout.itemSize =
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.register(UICollectionView.self, forCellWithReuseIdentifier: "MovieCell")
//        return cv
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = configureLayout()
        
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(260))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(100), heightDimension: .fractionalHeight(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 6
       }
       
    func collectionView(_ collectionView: UICollectionView,     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
        
        return cell
    }
       


}

