//
//  ImageViewCell.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ImageViewCell: UITableViewCell {

    private let thumbnail = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWith(url: String) {
        if let resource = URL(string: url) {
            thumbnail.kf.setImage(with: resource)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.removeFromSuperview()
        setUpConstraints()
    }
}

private extension ImageViewCell {
    
    func setUpConstraints() {
        addSubview(thumbnail)
        if UIDevice.current.orientation.isLandscape {
            thumbnail.snp.makeConstraints { make in
                make.centerX.equalTo(snp.centerX)
                make.height.width.equalTo(snp.height).dividedBy(2)
                make.top.equalTo(snp.top)
            }
        } else {
            thumbnail.snp.makeConstraints { make in
                make.centerX.equalTo(snp.centerX)
                make.height.width.equalTo(snp.width).multipliedBy(0.75)
                make.top.equalTo(snp.top)
            }
        }
    }
}
