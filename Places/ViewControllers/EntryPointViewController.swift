//
//  EntryPointViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit

class EntryPointViewController: UIViewController {
    
    let appController = AppController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if AppController.shared.isFirstLaunch {
            let vc: UIViewController = .instantiateViewController(withIdentifier: .onboarding)
            present(vc, animated: true, completion: nil)
        } else {
  
        }
    }
    
    deinit {
        print("\(String.init(describing: type(of: self))): deinit")
    }
    
    override func didReceiveMemoryWarning() {
        print("\(String.init(describing: type(of: self))): DidReceiveMemoryWarning")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("\(String.init(describing: type(of: self))): viewDidDisappear")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareSegue")
        super.prepare(for: segue, sender: sender)
    }
    
}
