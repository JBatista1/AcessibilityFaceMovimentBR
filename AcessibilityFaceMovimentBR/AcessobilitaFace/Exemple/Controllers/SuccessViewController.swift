//
//  SuccessViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 13/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class SuccessViewController: AccessibilityFaceAnchorViewController {

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()

    delegateNavigationBar = self
    delegateTabBar = self
    delegateCellView = self
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
     action.set(viewsAction: createViewAction())
  }

  func createViewAction() -> [ViewAction] {
    var viewsAction: [ViewAction] = [ViewAction(view: tableView, selector: #selector(selectedCell(_:)))]
    viewsAction.append(contentsOf: getViewActionNavigationAndTabBar())
    return viewsAction
  }
}

extension SuccessViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "AQUI MANO DO Cell\(indexPath.row)"

    return cell
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Tatu bola piranha"
  }
}

extension SuccessViewController: CellViewSelectedProtocol {
  func cellSelected(withIndex index: IndexPath) {
    title = "Row \(index.row)"
  }
}

extension SuccessViewController: TabBarSelectedProtocol, NavigationBackButtonProtocol {
  func tabBar(isSelectedIndex index: Int) {
    tabBarController?.selectedIndex = index
  }

  func actionNavigationBack() {
    navigationController?.popViewController(animated: true)
  }
}
