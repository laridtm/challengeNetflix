//
//  SearchCollectionReusableView.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 27/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit

class SearchCollectionReusableView: UICollectionReusableView {
  
    @IBOutlet weak var searchBar: UISearchBar!
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)

             return headerView
         }

         return UICollectionReusableView()

    }
 
}
