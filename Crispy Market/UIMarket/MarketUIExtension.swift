//
//  MarketUIColor.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func dequeueTypedCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T {
            return cell
        } else {
            fatalError("No cell of type \(String(describing: T.self)) has been registered for this tableView")
        }
    }
    
    func register(_ cellType: UITableViewCell.Type) {
        let name = String(describing: cellType.self)
        register(cellType, forCellReuseIdentifier: name)
    }
}

public extension UIView {

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }

        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }

            layer.borderColor = color.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { layer.borderWidth }

        set { layer.borderWidth = newValue }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }

        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
}

public extension UIWindow {
    
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}

public extension UIImage {
    func withTint(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

public extension Array where Element == UIWindow {
    
    func reload() {
        forEach { $0.reload() }
    }
}

