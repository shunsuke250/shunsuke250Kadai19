//
//  FruitTableViewCell.swift
//  CheckList23-10-21
//
//  Created by 副山俊輔 on 2023/10/21.
//

import UIKit

protocol FruitTableViewCellDelegate: AnyObject {
    func didSelectInfoButton(at indexPath: IndexPath)
}

class FruitTableViewCell: UITableViewCell {

    @IBOutlet private weak var listNameLabel: UILabel!
    @IBOutlet private weak var checkImageView: UIImageView!

    weak var delegate: FruitTableViewCellDelegate?
    private var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        checkImageView.image = UIImage(systemName: "checkmark")
    }

    @IBAction func didTapInfoButton(_ sender: Any) {
        if let indexPath = self.indexPath {
            delegate?.didSelectInfoButton(at: indexPath)
        }
    }

    func configure(_ fruit: Fruit, indexPath: IndexPath) {
        listNameLabel.text = fruit.name
        checkImageView.isHidden = !fruit.shouldShow
        self.indexPath = indexPath
    }
}
