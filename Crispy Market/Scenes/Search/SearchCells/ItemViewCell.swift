//
//  ItemViewCell.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ItemViewCell: UITableViewCell {

    private let priceLabel = MarketLabel(frame: .zero)
    private let buyingModeLabel = MarketSubhead(frame: .zero)
    private let thumbnail = UIImageView()
    private let titleLabel = MarketHeadline(frame: .zero)
    
    private var item: Items.FetchItems.SimpleViewModel? {
        didSet {
            updateUI()
        }
    }
    
    func initWith(viewModel: Items.FetchItems.SimpleViewModel) {
        item = viewModel
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ItemViewCell {
    
    func setUpConstraints() {
        for view in [buyingModeLabel, priceLabel, thumbnail, titleLabel] {
            addSubview(view)
        }
        thumbnail.snp.makeConstraints { make in
            make.bottom.left.top.equalTo(self).inset(8)
            make.height.width.equalTo(snp.width).dividedBy(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(thumbnail.snp.right).offset(8)
            make.right.top.equalTo(self).inset(8)
        }
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.width.equalTo(titleLabel.snp.width)
        }
        buyingModeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.width.equalTo(titleLabel.snp.width)
        }
    }
    
    func updateUI() {
        priceLabel.text = item?.price?.asCurrencyString
        buyingModeLabel.text = item?.buyingMode
        titleLabel.text = item?.title
        if let imageUrl = item?.thumbnail, let source = URL(string: imageUrl) {
            thumbnail.kf.setImage(with: source)
        }
    }
}
