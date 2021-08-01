//
//  SettingCell.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//

import UIKit

class SettingCell: UITableViewCell {
       
    // MARK: - Properties
    static var reuseIdentifier: String { return String(describing: Self.self) }
    
    var handler: (() -> Void)?
    var isInterfaceConfigured: Bool = false
    private lazy var valueSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = Asset.accent0.color
        view.addTarget(self, action: #selector(actionHandler), for: .valueChanged)
        return view
    }()
    
    private lazy var iconContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 14)
        view.adjustsFontSizeToFitWidth = true
        view.backgroundColor = Asset.other2.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    init() {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
        accessoryType = .none
        isUserInteractionEnabled = true
        configureInterface()
        accessoryType = .none
    }
           
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = true
        configureInterface()
        accessoryType = .none
//        configureInterface()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init with code fatal error")
//        Log(text: "init with coder", object: nil)
    }
    
    // MARK: - Helper functions
    func configureInterface(with options: [String: Any]? = nil) {
        if isInterfaceConfigured { return }
        
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(iconContainer)
        contentView.addSubview(label)
        contentView.addSubview(valueSwitch)
        tintColor = Asset.other1.color
        contentView.backgroundColor = Asset.other2.color
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 32),
            iconContainer.heightAnchor.constraint(equalToConstant: 32),
            
            label.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.trailingAnchor.constraint(equalTo: valueSwitch.leadingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                        
            valueSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            valueSwitch.widthAnchor.constraint(equalToConstant: 60),
            valueSwitch.heightAnchor.constraint(equalToConstant: 32),
            valueSwitch.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: iconContainer.widthAnchor),
            iconImageView.heightAnchor.constraint(equalTo: iconContainer.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(option: SettingsOptionType) {
        switch option {
        case .staticCell(let model):
            self.handler = model.handler
            self.valueSwitch.isHidden = true
            self.iconImageView.setImage(model.icon)
            self.label.text = model.title
        case .switchCell(let model):
            self.handler = model.handler
            self.iconImageView.setImage(model.icon)
            self.label.text = model.title
            self.valueSwitch.isOn = model.isOn
        }
    }
    
    override func prepareForReuse() {
        valueSwitch.isHidden = true
        iconImageView.image = nil
    }
    
    @objc
    private func actionHandler() {
        Log(text: "shareButtonTapped", object: nil)
        handler?()
    }    
}
