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
    action.setTypeStartAction(withType: .tongue)
    action.set(viewsAction: createViewAction())
  }

  func createViewAction() -> [ViewAction] {
    var viewsAction: [ViewAction] = [ViewAction(view: tableView, selector: #selector(handleTap(_:)))]
    viewsAction.append(contentsOf: getViewsActionWithTabBar())
    return viewsAction
  }

  @objc func handleTap(_ sender: Any? = nil) {
    guard let index = sender as? IndexPath else { return }
    print(index)
  }
}

extension SuccessViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "AQUI MANO DO Cell\(indexPath.row)"
    cell.accessibilityIdentifier = "row:\(indexPath.row) section: \(indexPath.section)"
    return cell
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Tatu bola piranha"
  }
}
