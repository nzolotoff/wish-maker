//
//  WishStoringView.swift
//  WishMaker
//
//  Created by Nikita Zolotov on 22.01.2025.
//

import UIKit


final class WishCalendarView: UIView {
    
    // MARK: - Constants
    enum Constants {
        
        // collection
        static let collectionInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        static let collectionTopOffset: CGFloat = 4
        static let collectionNumberOfItemsInSection: Int = 10
        static let collectionCellHeight: CGFloat = 79
        static let collectionCellWidthDecrement: CGFloat = 40
        static let collectionMinimumLineSpacing: CGFloat = 12
        static let collectionInteritemSpacing: CGFloat = 12
    }
    
    // MARK: - Fields
    private let myCollection: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: Lyfecycle
    init () {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = .white
        configureCollectionView()
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
        myCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.collectionTopOffset).isActive = true
        myCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension WishCalendarView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return Constants.collectionNumberOfItemsInSection
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
        
        wishEventCell.configureCell(
            with: WishEventModel(
                title: "Fly to Maldives",
                description: "my wish is to have a great vacation on a coast",
                startDate: "Start date",
                endDate: "End Date"
            )
        )
        return cell
    }
}

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
}
