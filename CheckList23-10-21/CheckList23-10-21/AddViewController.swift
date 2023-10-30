//
//  AddViewController.swift
//  CheckList23-10-21
//
//  Created by 副山俊輔 on 2023/10/21.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func addFruit(name: String)
    func editFruit(name: String, index: IndexPath)
}

class AddViewController: UIViewController {

    @IBOutlet private weak var titleTextField: UITextField!

    weak var delegate: AddViewControllerDelegate?
    private var defaultTitle = ""
    private var index: IndexPath?
    private var pattern: Pattern = .addNewItem

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleTextField.text = defaultTitle
    }

    @IBAction private func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func save(_ sender: UIBarButtonItem) {
        guard let fruit = titleTextField.text?.trimmingCharacters(in: .whitespaces),
              !fruit.isEmpty else {
            return
        }
        switch pattern {
        case .addNewItem:
            delegate?.addFruit(name: fruit)
        case .editExistItem:
            if let index = index {
                delegate?.editFruit(name: fruit, index: index)
            }
        }
        dismiss(animated: true, completion: nil)
    }

    func configure(_ data: String, index: IndexPath, pattern: Pattern) {
        defaultTitle = data
        self.pattern = pattern
        self.index = index
    }
}
