//
//  FruitTableViewCell.swift
//  CheckList23-10-21
//
//  Created by 副山俊輔 on 2023/10/21.
//

import UIKit

class FruitTableViewCell: UITableViewCell {

    @IBOutlet private weak var listNameLabel: UILabel!
    @IBOutlet private weak var checkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        checkImageView.image = UIImage(systemName: "checkmark")
    }

    @IBAction func didTapInfoButton(_ sender: UIButton) {
        
    }
    
    func configure(_ fruit: Fruit) {
        listNameLabel.text = fruit.name
        checkImageView.isHidden = !fruit.shouldShow
    }
}
