//
//  CollectionTestViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 26/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class CollectionTestViewController: AccessibilityFaceAnchor {

  @IBOutlet weak var collectionView: UICollectionView!

  private let identifier = "cell"

  override func viewDidLoad() {
    super.viewDidLoad()
    action.setTypeStartAction(withType: .tongue)
    action.set(viewsAction: createViewAction())
    collectionViewConfiguration()
    
  }
  func collectionViewConfiguration() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  func createViewAction() -> [ViewAction] {
    let viewsAction: [ViewAction] = [ViewAction(view: collectionView, selector: #selector(handleTap(_:)))]
    return viewsAction
  }

  @objc func handleTap(_ sender: Any? = nil) {
    guard let index = sender as? IndexPath else { return }
    print(index)
  }
}

extension CollectionTestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CellCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.setup(numberItem: indexPath.item)
    return cell
  }
}
