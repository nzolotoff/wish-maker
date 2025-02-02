//
//  NavigationView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 28.01.2025.
//

import UIKit

protocol NavigationBarViewDelegate {
    func goBackButtonTapped()
    func addButtonTapped()
}

class NavigationBarView: UIView {
    // MARK: - Constants
    enum Constants {
        // go back button name
        static let goBackButtonName: String = "chevron.backward"
        
        // go back button name
        static let addButtonName: String = "plus"
        
        // navigation stack
        static let navigationStackViewOffsetLeading: CGFloat = 20
        static let navigationStackViewOffsetTop: CGFloat = 16
        static let navigationStackViewOffsetTrailing: CGFloat = -20
        static let navigationStackViewOffsetBottom: CGFloat = -16

        // self height
        static let selfHeight: CGFloat = 56
    }

    // MARK: - Fields
    private let goBackButton: UIButton = UIButton(type: .system)
    private let addButton: UIButton = UIButton(type: .system)
    private let navigationStack: UIStackView = UIStackView()
    
    // MARK: - Variables
    var goBackButtonAction: (() -> Void)?
    var addButtonAction: (() -> Void)?
    
    // MARK: - Lyfecycle
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        goBackButton.setImage(UIImage(systemName: Constants.goBackButtonName), for: .normal)
        addButton.setImage(UIImage(systemName: Constants.addButtonName), for: .normal)
        
        goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        for button in [goBackButton, addButton] {
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        navigationStack.addArrangedSubviews(goBackButton, addButton)
        navigationStack.axis = .horizontal
        navigationStack.distribution = .equalSpacing
        navigationStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(navigationStack)
        navigationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.navigationStackViewOffsetLeading).isActive = true
        navigationStack.topAnchor.constraint(equalTo: topAnchor, constant: Constants.navigationStackViewOffsetTop).isActive = true
        navigationStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.navigationStackViewOffsetTrailing).isActive = true
        navigationStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.navigationStackViewOffsetBottom).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: Constants.selfHeight).isActive = true
    }
    
    // MARK: - Actions
    @objc private func goBackButtonTapped() {
        goBackButtonAction?()
    }
    
    @objc private func addButtonTapped() {
        addButtonAction?()
    }
}
