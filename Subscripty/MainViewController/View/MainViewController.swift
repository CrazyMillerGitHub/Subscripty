//
//  ContentView.swift
//  Subscripty
//
//  Created by Михаил Борисов on 11.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import SwiftUI

final class MainViewController: UIViewController, MainViewCallable {

    // MARK: - properties
    private lazy var addButton = UIHostingController(rootView: AddButtonView()).with { button in
        button.view.translatesAutoresizingMaskIntoConstraints = false
        button.view.isUserInteractionEnabled = true
        button.view.backgroundColor = UIColor.clear
    }

    private var presenter: MainViewPresenter!

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).with { collectionView in
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
    }

    internal lazy var searchViewController = UISearchController().with { searchViewController in
        searchViewController.obscuresBackgroundDuringPresentation = false
        searchViewController.searchBar.setScopeBarButtonBackgroundImage(UIImage(), for: .focused)
        searchViewController.searchBar.showsScopeBar = true
    }

    // MARK: - UI LifeCycle
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainViewPresenter(delegate: self, collectionView: collectionView)
        configureButton()
        configureNavigationBar()

    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.topItem?.title = "Subscripty"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(presentProfileView))
    }

    private func configureButton() {

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonPressed))
        addButton.view.addGestureRecognizer(tapGesture)
        addChild(addButton)
        view.addSubview(addButton.view)
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.view.widthAnchor.constraint(equalToConstant: 46),
            addButton.view.heightAnchor.constraint(equalToConstant: 46),
            addButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            addButton.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }

    @objc
    private func addButtonPressed() {
        let controller = UIHostingController(rootView: AddCardView(dismissAction: { [weak self] card in
            self?.dismiss(animated: true, completion: nil)
            let context = CoreDataManager.shared.context(on: .main)
            card.toCardEntity(context: context)

        }).environmentObject(CardEnvironment(card: CardElement())))
//        let transitionDelegate = SPStorkTransitioningDelegate()
//        transitionDelegate.customHeight = view.bounds.height / 1.3
//        controller.transitioningDelegate = transitionDelegate
//        controller.modalPresentationStyle = .custom
//        controller.modalPresentationCapturesStatusBarAppearance = true
//        self.present(controller, animated: true, completion: nil)
    }

    @objc
    private func presentProfileView() {
        let controller = ProfileViewController()
        self.present(controller, animated: true, completion: nil)
    }

}

extension MainViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration()
    }

}
