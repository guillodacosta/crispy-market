//
//  MarketTheme.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import UIKit

protocol Theme {
    var backgroundColor: UIColor { get }
    var backgroundInnerColor: UIColor { get }
    var barStyle: UIBarStyle { get }
    var errorColor: UIColor { get }
    var labelColor: UIColor { get }
    var secondaryLabelColor: UIColor { get }
    var secondaryTint: UIColor { get }
    var selectionColor: UIColor { get }
    var separatorColor: UIColor { get }
    var subtleLabelColor: UIColor { get }
    var tint: UIColor { get }
    
    func apply(for application: UIApplication)
    
    func extend()
}

extension Theme {
    
    func apply(for application: UIApplication) {
        application.keyWindow?.tintColor = tint
        
        UITabBar.appearance().with {
            $0.barStyle = barStyle
            $0.tintColor = backgroundInnerColor
        }
        
        UINavigationBar.appearance().with {
            $0.barStyle = barStyle
            $0.isTranslucent = false
            $0.barTintColor = backgroundColor
            $0.titleTextAttributes = [
                .foregroundColor: backgroundInnerColor
            ]
            
            if #available(iOS 11.0, *) {
                $0.largeTitleTextAttributes = [
                    .foregroundColor: backgroundInnerColor
                ]
            }
        }
        
        UISearchBar.appearance().with {
            $0.layer.borderColor = backgroundColor.cgColor
            $0.barTintColor = backgroundColor
            $0.tintColor = tint
        }
        
        UITableView.appearance().with {
            $0.backgroundColor = backgroundInnerColor
            $0.separatorColor = separatorColor.withAlphaComponent(0.2)
            $0.separatorStyle = .singleLine
            $0.rowHeight = UITableView.automaticDimension
        }
        
        UITableViewCell.appearance().with {
            $0.backgroundColor = .clear
            $0.tintColor = tint
            $0.textLabel?.textColor = tint
        }
        
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .textColor = secondaryLabelColor
        
        UILabel.appearance().textColor = tint
        for label in [MarketLabel.self, MarketHeadline.self, MarketSubhead.self, MarketFootnote.self] {
            label.appearance().textColor = tint
            label.appearance().numberOfLines = 0
            label.appearance().lineBreakMode = .byWordWrapping
            label.appearance().adjustsFontSizeToFitWidth = false
        }
        
        MarketHeadline.appearance().textColor = secondaryTint
        MarketSubhead.appearance().textColor = secondaryLabelColor
        MarketFootnote.appearance().textColor = subtleLabelColor
        guard let latoRegular = UIFont(name: "Lato-Regular", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "Lato-Regular" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        guard let latoBold = UIFont(name: "Lato-Bold", size: UIFont.smallSystemFontSize) else {
            fatalError("""
                Failed to load the "Lato-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        for label in [MarketLabel.self, MarketSubhead.self, MarketFootnote.self] {
            if #available(iOS 11.0, *) {
                label.appearance().font = UIFontMetrics.default.scaledFont(for: latoRegular)
            } else {
                label.appearance().font = latoRegular
            }
            label.appearance().adjustsFontForContentSizeCategory = true
        }
        if #available(iOS 11.0, *) {
            MarketHeadline.appearance().font = UIFontMetrics.default.scaledFont(for: latoBold)
        } else {
            MarketHeadline.appearance().font = latoBold
        }
        
        UIView.appearance(whenContainedInInstancesOf: [MarketView.self]).with {
            $0.cornerRadius = 10
        }
        
        MarketLabel.appearance(whenContainedInInstancesOf: [MarketView.self, MarketView.self]).textColor = subtleLabelColor
        MarketHeadline.appearance(whenContainedInInstancesOf: [MarketView.self, MarketView.self]).textColor = secondaryLabelColor
        MarketSubhead.appearance(whenContainedInInstancesOf: [MarketView.self, MarketView.self]).textColor = secondaryTint
        MarketFootnote.appearance(whenContainedInInstancesOf: [MarketView.self, MarketView.self]).textColor = labelColor
        
        extend()
        application.windows.reload()
    }
}

struct MarketTheme: Theme {
    let backgroundColor: UIColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0, alpha: 1)
    let backgroundInnerColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let barStyle: UIBarStyle = .default
    let errorColor: UIColor = #colorLiteral(red: 0.9294117647, green: 0.09803921569, blue: 0.3568627451, alpha: 1)
    let labelColor: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    let secondaryLabelColor: UIColor = #colorLiteral(red: 0.1568627451, green: 0.1960784314, blue: 0.4666666667, alpha: 1)
    let secondaryTint: UIColor = #colorLiteral(red: 0.9294117647, green: 0.09803921569, blue: 0.3568627451, alpha: 1)
    let selectionColor: UIColor = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1).withAlphaComponent(50.0)
    let separatorColor: UIColor = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
    let subtleLabelColor: UIColor = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
    let tint: UIColor = #colorLiteral(red: 0.1568627451, green: 0.1960784314, blue: 0.4666666667, alpha: 1)
}

extension MarketTheme {
    
    func extend() {
        UIImageView.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).with {
            $0.layer.cornerRadius = $0.frame.width / 8
            $0.layer.masksToBounds = true
        }
        
        UIImageView.appearance(whenContainedInInstancesOf: [UIButton.self, UITableViewCell.self]).with {
            $0.borderWidth = 0
        }
    }
}

