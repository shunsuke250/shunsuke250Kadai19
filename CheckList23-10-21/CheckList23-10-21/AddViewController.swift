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

    enum Mode {
        case add
        case edit(name: String, indexPath: IndexPath)
    }

    @IBOutlet private weak var titleTextField: UITextField!

    weak var delegate: AddViewControllerDelegate?

    private var mode: Mode = .add

    static func instantiate(mode: Mode) -> AddViewController {
        let addViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "addView") as! AddViewController
        addViewController.mode = mode
        return addViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch mode {
        case .add:
            break
        case .edit(let name, _):
            titleTextField.text = name
        }
    }

    @IBAction private func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func save(_ sender: UIBarButtonItem) {
        guard let fruit = titleTextField.text?.trimmingCharacters(in: .whitespaces),
              !fruit.isEmpty else {
            return
        }
        
        switch mode {
        case .add:
            delegate?.addFruit(name: fruit)
        case let .edit(_, indexPath):
            delegate?.editFruit(name: fruit, index: indexPath)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
