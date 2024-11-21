//
//  WishStoringViewController.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 21.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Fields
    private let wishesTable: UITableView = UITableView(frame: .zero)

    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = .cyan
        configureWishesTable()
    }
    
    private func configureWishesTable() {
        wishesTable.backgroundColor = .red
        wishesTable.separatorStyle = .none
        wishesTable.dataSource = self
        wishesTable.layer.cornerRadius = 20
        wishesTable.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(wishesTable)
        NSLayoutConstraint.activate([
            wishesTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishesTable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            wishesTable.heightAnchor.constraint(equalToConstant: 500),
            wishesTable.widthAnchor.constraint(equalToConstant: 300)
            ])
    }
}

// MARK: UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
