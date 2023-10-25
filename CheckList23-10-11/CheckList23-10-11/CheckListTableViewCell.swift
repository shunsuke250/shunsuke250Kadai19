//
//  CheckListTableViewCell.swift
//  CheckList23-10-11
//
//  Created by 副山俊輔 on 2023/10/12.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {

    let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let checkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.tintColor = .orange
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }

    private func setupComponents() {
        contentView.addSubview(customLabel)
        contentView.addSubview(checkImage)

        customLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(checkImage.snp.right).offset(10)
            $0.right.equalToSuperview()
        }
        checkImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.size.equalTo(30)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
