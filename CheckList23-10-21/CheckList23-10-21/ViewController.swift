//
//  ViewController.swift
//  CheckList23-10-21
//
//  Created by 副山俊輔 on 2023/10/21.
//

import UIKit

class ViewController: UIViewController {

    private enum Error: Swift.Error {
        case dataNotFound
    }

    @IBOutlet private weak var tableView: UITableView!

    private var fruits = [
        Fruit(name: "りんご", shouldShow: false),
        Fruit(name: "みかん", shouldShow: true),
        Fruit(name: "バナナ", shouldShow: false),
        Fruit(name: "パイナップル", shouldShow: true)
    ]

    private let cellIdentifier = "CustomCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FruitTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        try? loadFruitsFromUserDefaults()
    }

    @IBAction private func addFruit(_ sender: Any) {
        showAddViewControllerForEditing(mode: .add)
    }

    private func reverseImageFlag(index: Int) {
        fruits[index].shouldShow.toggle()
    }

    private func showAddViewControllerForEditing(mode: AddViewController.Mode) {
        let addViewController = AddViewController.instantiate(mode: mode)
        addViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: addViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    private func saveFruitsToUserDefaults() throws {
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(fruits)
        UserDefaults.standard.set(encodedData, forKey: "fruitsKey")
    }

    private func loadFruitsFromUserDefaults() throws {
        guard let savedData = UserDefaults.standard.data(forKey: "fruitsKey") else {
            throw Error.dataNotFound
        }
        let decodedFruits = try JSONDecoder().decode([Fruit].self, from: savedData)
        fruits = decodedFruits
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        fruits.count
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        42
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        ) as! FruitTableViewCell
        cell.delegate = self
        cell.configure(fruits[indexPath.row], indexPath: indexPath)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        reverseImageFlag(index: indexPath.row)
        try? saveFruitsToUserDefaults()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            fruits.remove(at: indexPath.row)
            try? saveFruitsToUserDefaults()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: AddViewControllerDelegate {
    func editFruit(name: String, index: IndexPath) {
        fruits[index.row] = Fruit(name: name, shouldShow: false)
        try? saveFruitsToUserDefaults()
        tableView.reloadData()
    }

    func addFruit(name: String) {
        fruits.append(Fruit(name: name, shouldShow: false))
        try? saveFruitsToUserDefaults()
        tableView.reloadData()
    }
}

extension ViewController: FruitTableViewCellDelegate {
    func didSelectInfoButton(at indexPath: IndexPath) {
        showAddViewControllerForEditing(
            mode: .edit(
                name: fruits[indexPath.row].name,
                indexPath: indexPath
            )
        )
    }
}
