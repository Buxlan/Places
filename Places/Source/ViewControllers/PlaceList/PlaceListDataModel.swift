//
//  PlaceListTableViewDataModel.swift
//  Places
//
//  Created by  Buxlan on 7/21/21.
//

import UIKit
import FirebaseDatabase
import Firebase

class PlaceListDataModel: NSObject {
    
    override init() {
        super.init()
        ref = database.reference()
    }
    //
    //
    // MARK: - Working with Database, needed to rewrite!!!
    
    var database = Database.database(app: FirebaseApp.app()!,
                                     url: "https://theplaces-c6a9c-default-rtdb.europe-west1.firebasedatabase.app")
    var ref: DatabaseReference?
    var handleRef: UInt = 0
    var isOffline = false
    
    func updateData(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                        
            guard let self = self else { return }
                        
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
            
            completion()
            Log(text: "Place list view model: Data has loaded and competion has executed")
     
        }
    }
    
    deinit {
        if let dbRef = self.ref,
           self.handleRef != 0 {
            dbRef.removeObserver(withHandle: self.handleRef)
        }
    }
    
}
