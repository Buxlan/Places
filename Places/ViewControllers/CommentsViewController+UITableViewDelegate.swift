//
//  PlaceViewController+UITableViewDelegate.swift
//  Places
//
//  Created by  Buxlan on 5/18/21.
//

import UIKit

extension CommentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected indexPath: \(indexPath)")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 250

    }
    
}
