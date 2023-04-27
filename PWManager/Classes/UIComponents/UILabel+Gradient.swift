//
//  UILabel+Gradient.swift
//  PWManager
//
//  Created by chaichai on 2023/4/27.
//

import Foundation

extension UILabel {
    var gradientColor: (from: UIColor, to: UIColor) {
        set(color) {
            let size = bounds.size
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            ///设置渐变颜色
            guard let gradientRef = CGGradient(
                colorsSpace: colorSpace,
                colors: [color.from.cgColor, color.to.cgColor] as CFArray,
                locations: nil
            ) else {
                return
            }
            let startPoint = CGPoint(x: 0, y: 0.5)
            let endPoint = CGPoint(x: size.width, y: 0.5)
            context.drawLinearGradient(
                gradientRef,
                start: startPoint,
                end: endPoint,
                options: CGGradientDrawingOptions(
                    arrayLiteral: .drawsBeforeStartLocation,
                        .drawsAfterEndLocation
                )
            )
            let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if let img = gradientImage {
                textColor = UIColor(patternImage: img)
            }
        }
        get {
            return (textColor, textColor)
        }
    }
}
