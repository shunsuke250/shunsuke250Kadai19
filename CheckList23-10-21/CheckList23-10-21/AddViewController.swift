//
//  AddViewController.swift
//  CheckList23-10-21
//
//  Created by 副山俊輔 on 2023/10/21.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func saveFruit(name: String)
}

class AddViewController: UIViewController {

    @IBOutlet private weak var addTextField: UITextField!

    weak var delegate: AddViewControllerDelegate?

    @IBAction private func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func save(_ sender: UIBarButtonItem) {
        guard let fruit = addTextField.text?.trimmingCharacters(in: .whitespaces),
              !fruit.isEmpty else { return }
        delegate?.saveFruit(name: fruit)
        dismiss(animated: true, completion: nil)
    }

    func configure(_ data: String) {
        // addTextFieldがnilになる
        if let textField = addTextField {
            textField.text = data
        }
    }
}
