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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 6
       }
       
    func collectionView(_ collectionView: UICollectionView,     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath)
        
        return cell
    }
       


}

