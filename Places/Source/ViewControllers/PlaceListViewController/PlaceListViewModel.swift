//
//  PlaceListViewModel.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class PlaceListViewModel {
    
    var database = Database.database(app: FirebaseApp.app()!, url: "https://theplaces-c6a9c-default-rtdb.europe-west1.firebasedatabase.app")
    var ref: DatabaseReference?
    var handleRef: UInt = 0
    var items: [Place]
    weak var tableView: UITableView?
    var isOffline = false
    
    init(tableView: UITableView) {
        self.tableView = tableView
        items = [Place]()
        ref = database.reference()
        Log(text: "database ", object: ref)
    }
    
    func updateData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                        
            guard let self = self else { return }
            
            self.items = PlaceController().collections[0].places
            
            let connectedRef = self.database.reference(withPath: ".info/connected")
            connectedRef.observe(.value) { [weak self] snapshot in
                if let value = snapshot.value as? Bool, !value {
                    self?.database.goOnline()
                    self?.isOffline = true
                    return
                }
            }
            
            if self.isOffline {
                do {
                    sleep(1)
                }
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    self.updateData(completion: completion)
                }
                return
            }
            
            if let dbRef = self.ref,
               self.handleRef != 0 {
                dbRef.removeObserver(withHandle: self.handleRef)
            }
            
            let dbRef = self.database.reference().child("condition")
            dbRef.keepSynced(true)
            self.ref = dbRef
            
            self.handleRef = dbRef.observe(.value) { (snapshot) in
                if snapshot.exists() {
                    if let value = snapshot.value as? Bool {
                        print("Got data \(value)")
                    }
                } else {
                    print("No data available")
                }
                self.database.goOffline()
            }
//            self.ref.child("condition").getData { (error, snapshot) in
//                if snapshot.exists() {
//                    if let value = snapshot.value as? Bool {
//                        print("Got data \(value)")
//                    }
//                }
//                else {
//                    print("No data available")
//                }
//                self.database.goOffline()
//            }
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
                completion()
            }
            
            Log(text: "Data was loaded and table view was reloaded", object: self.tableView)
     
        }
    }
    
    deinit {
        if let dbRef = self.ref,
           self.handleRef != 0 {
            dbRef.removeObserver(withHandle: self.handleRef)
        }
    }
    
}
