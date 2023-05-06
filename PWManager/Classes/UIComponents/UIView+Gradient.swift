//
//  UIView+Gradient.swift
//  PWManager
//
//  Created by chaichai on 2023/4/27.
//

import Foundation


extension UIView {
    
    fileprivate class _autoGradView: UIView {

        let fromColor: UIColor
        let toColor: UIColor
        let startPoint: CGPoint
        let endPoint: CGPoint
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init(from: UIColor, to: UIColor, start: CGPoint, end: CGPoint) {
            fromColor = from
            toColor = to
            startPoint = start
            endPoint = end
            super.init(frame: .zero)
            layer.addSublayer(lay)
            isUserInteractionEnabled = false
        }
        
        lazy var lay: CAGradientLayer = {
            let layer1 = CAGradientLayer()
            layer1.colors = [fromColor.cgColor, toColor.cgColor]
            layer1.locations = [0, 1]
            layer1.startPoint = startPoint
            layer1.endPoint = endPoint
            return layer1
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            lay.frame = bounds
        }
    }
    
    func makeGradient(from: UIColor, to: UIColor, start: CGPoint, end: CGPoint) {
        if let _ = subviews.first(where: { $0 is _autoGradView }) {
            return
        }
        let s = _autoGradView(from: from, to: to, start: start, end: end)
        s.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(s, at: 0)
        s.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        s.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        s.topAnchor.constraint(equalTo: topAnchor).isActive = true
        s.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
