//
//  PlaceViewController.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit

class PlaceViewController: UIViewController {

    lazy var firstButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Go back", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = UIColor.secondaryLabel
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupNavigationBar()
    }
    
    func setupUI() {
        
        print(view.frame)
        view.backgroundColor = .white
        view.addSubview(firstButton)

        setupConstraints()
    }
    
    func setupConstraints() {
        
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        
        let widthButtonAnchor = firstButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        widthButtonAnchor.priority = UILayoutPriority.defaultHigh
        
        let constraints: [NSLayoutConstraint] = [
            firstButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            firstButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            widthButtonAnchor,
            firstButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNavigationBar() {
        navigationController?.title = "Place"
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backButtonTitle = ""
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right nav item", style: .plain, target: self, action: #selector(goBackButtonTapped))
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func goBackButtonTapped() {
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: { print("Went back") } )
        }
    }

}
