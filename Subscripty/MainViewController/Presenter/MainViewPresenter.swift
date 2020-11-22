//
//  MainViewPresenter.swift
//  Subscripty
//
//  Created by Михаил Борисов on 12.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

protocol MainViewCallable where Self: UIViewController {
    var searchViewController: UISearchController { get }
}

final class MainViewPresenter: NSObject, UICollectionViewDelegate, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    // MARK: - prepare properties and dataSource
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, CardEntity>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, CardEntity>
    private var fetchedResultsController: NSFetchedResultsController<CardEntity>!

    private lazy var dataSource = makeDataSource()

    private var collectionView: UICollectionView

    private weak var delegate: MainViewCallable?

    private enum Section: String, CaseIterable {
        case main
    }

    // MARK: - lifecycle

    internal init(delegate: MainViewCallable, collectionView: UICollectionView) {
        self.delegate = delegate
        self.collectionView = collectionView
        super.init()
        self.configureCollectionViewCell()
        setupFetchedResultsController()
        setupSearchController()
    }

    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, mainItem) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? HostingCollectionViewCell<CardView> else { return UICollectionViewCell() }

            cell.host(CardView(mode: CardView.CardMode.big), parent: self.delegate!, environment: mainItem)
            return cell
        }
    }

    private func setupFetchedResultsController(_ currentSearchText: String = "") {
        let request: NSFetchRequest<CardEntity> = CardEntity.fetchRequest()
        request.fetchBatchSize = 30
        if !currentSearchText.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS %@", currentSearchText)
        }
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.context(on: .main), sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
            applySnapshot()
        } catch {
            print("Fetch failed")
        }
    }

    private func configureCollectionViewCell() {
        collectionView.delegate = self
        collectionView.frame = delegate?.view.frame ?? .zero
        delegate?.view.addSubview(collectionView)
        collectionView.register(HostingCollectionViewCell<CardView>.self, forCellWithReuseIdentifier: "myCell")
    }

    internal func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        setupFetchedResultsController(text)
    }

    private func setupSearchController() {
        guard let delegate = delegate else { return }

        delegate.navigationItem.searchController = delegate.searchViewController
        delegate.searchViewController.searchResultsUpdater = self
    }

    internal func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(fetchedResultsController.fetchedObjects ?? [])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    internal func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        applySnapshot()
    }

}

extension MainViewPresenter: UICollectionViewDelegateFlowLayout {

    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let delegate = delegate else {
            return .zero
        }

        return CGSize(width: delegate.view.frame.width - 30, height: 180)
    }

    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 28, left: 15, bottom: 28, right: 15)
    }

    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 33
    }
}
