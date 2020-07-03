//
//  ItemEmptyCell.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ItemEmptyCell: UITableViewCell {

    private let thumbnail = UIImageView()
    private let titleLabel = MarketHeadline(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ItemEmptyCell {
    
    func setUpConstraints() {
        for view in [thumbnail, titleLabel] {
            addSubview(view)
        }
        thumbnail.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.height.width.equalTo(snp.width).dividedBy(2)
            make.top.equalTo(snp.top).inset(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(8)
            make.right.equalTo(snp.right).offset(8)
            make.top.equalTo(thumbnail.snp.bottom).offset(8)
        }
    }
    
    func updateUI() {
        let image = #imageLiteral(resourceName: "logo-no-color-mp.png")
        if #available(iOS 13.0, *) {
            thumbnail.image = image.withTintColor(#colorLiteral(red: 0.1568627451, green: 0.1960784314, blue: 0.4666666667, alpha: 1))
        } else {
            thumbnail.image = image.withTint(color: #colorLiteral(red: 0.1568627451, green: 0.1960784314, blue: 0.4666666667, alpha: 1))
        }
        titleLabel.textAlignment = .center
        titleLabel.text = NSLocalizedString("SearchSceneEmptyTitle", comment: "empty state title")
    }
}
