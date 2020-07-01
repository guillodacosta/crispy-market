//
//  TitleViewCell.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import SnapKit

class TitleViewCell: UITableViewCell {

    private let titleLabel = MarketHeadline(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        setUpConstraints()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWith(title: String) {
        titleLabel.text = title
    }
}

private extension TitleViewCell {
    
    func setUpConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).inset(4)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.9)
            make.top.equalTo(snp.top).inset(4)
        }
    }
    
    func updateUI() {
        titleLabel.textAlignment = .justified
    }
}
