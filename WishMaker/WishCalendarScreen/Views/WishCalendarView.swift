//
//  WishStoringView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 22.01.2025.
//

import UIKit

protocol WishCalendarViewDelegate: AnyObject {
    func goBackButtonWasTapped()
    func addButtonWastapped()
    
    func getEvents() -> [WishEventModel]?
    func getEvent(byId id: Int) -> WishEventModel
    func deleteEvent(byId id: Int)
}

final class WishCalendarView: UIView {
    
    // MARK: - Constants
    enum Constants {
        // navigation title
        static let navigationBarViewTitle: String = "My events"
        
        // collection
        static let collectionTopOffset: CGFloat = 4
        static let collectionCellHeight: CGFloat = 79
        static let collectionCellWidthDecrement: CGFloat = 40
        static let collectionMinimumLineSpacing: CGFloat = 12
        static let collectionInteritemSpacing: CGFloat = 12
        static let collectionInset: UIEdgeInsets = UIEdgeInsets(
            top: 8,
            left: 20,
            bottom: 8,
            right: 20
        )
        
        // delete action context menu
        static let deleteActionTitle: String = "Delete"
        static let deleteActionImage: UIImage? = UIImage(systemName: "trash")
    }
    
    // MARK: - Fields
    private let navigationBarView: NavigationBarView = NavigationBarView(
        navigationTitle: Constants.navigationBarViewTitle
    )
    private let myCollection: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Variables
    weak var delegate: WishCalendarViewDelegate?
    
    // MARK: Lyfecycle
    init () {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reload collection data
    func reloadData() {
        myCollection.reloadData()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = .white
        configureNavigationBarView()
        configureCollectionView()
    }
    
    private func configureNavigationBarView() {
        setActionForGoBackButton()
        setActionForAddButton()
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(navigationBarView)
        navigationBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        navigationBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func configureCollectionView() {
        myCollection.dataSource = self
        myCollection.delegate = self
        myCollection.backgroundColor = .white
        myCollection.alwaysBounceVertical = true
        myCollection.showsVerticalScrollIndicator = false
        myCollection.contentInset = Constants.collectionInset
        myCollection.translatesAutoresizingMaskIntoConstraints = false
        
        // cell register
        if let layout = myCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.collectionInteritemSpacing
            layout.minimumLineSpacing = Constants.collectionMinimumLineSpacing
            
            layout.invalidateLayout()
        }
        // temporary
        myCollection.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        
        addSubview(myCollection)
        myCollection.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: Constants.collectionTopOffset).isActive = true
        myCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Actions
    private func setActionForGoBackButton() {
        navigationBarView.goBackButtonAction = { [weak self] in
            self?.delegate?.goBackButtonWasTapped()
        }
    }
    
    private func setActionForAddButton() {
        navigationBarView.addButtonAction = { [weak self] in
            self?.delegate?.addButtonWastapped()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.delegate?.getEvents()?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WishEventCell.reuseIdentifier,
            for: indexPath
        )
        guard let wishEventCell = cell as? WishEventCell else { return cell }
        
        guard let event = self.delegate?.getEvent(byId: indexPath.row) else { return cell }
        
        wishEventCell.configureCell(with: event)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.bounds.width - Constants.collectionCellWidthDecrement, height: Constants.collectionCellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("cell tapped at index \(indexPath.item)")
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        canEditItemAt indexPath: IndexPath
    ) -> Bool {
        true
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { suggestedActions in
            let deleteAction = UIAction(
                title: Constants.deleteActionTitle,
                image: Constants.deleteActionImage,
                attributes: .destructive
            ) { [weak self] action in
                self?.delegate?.deleteEvent(byId: indexPath.row)
                self?.reloadData()
            }
            return UIMenu(title: "", children: [deleteAction])
        }
    }
}
