//
//  RootViewController+UICollectionViewDelegate.swift
//  Places
//
//  Created by  Buxlan on 5/17/21.
//

import UIKit

extension PlaceListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { fatalError() }
        pushPlaceViewController(item)
        
    }
    
}


