//
//  WishButton.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 18.01.2025.
//

import UIKit

class WishButton: UIView {
    // MARK: - Constants
    enum Constants {
        static let wishButtonCorner: CGFloat = 20
        static let wishButtonHeight: CGFloat = 52

    }
    
    // MARK: - Variables
    var action: (() -> Void)?
    
    // MARK: - Fields
    private let button: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        configureWishButton(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureWishButton(_ title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = Constants.wishButtonCorner
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(wishButtonWasTapped), for: .touchUpInside)
        
        addSubview(button)
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: Constants.wishButtonHeight).isActive = true
    }
    
    // MARK: - Actions
    @objc private func wishButtonWasTapped() {
        action?()
    }
}
