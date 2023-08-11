//
//  PWManager.swift
//  PWManager
//
//  Created by chaichai on 2023/4/27.
//

import Foundation
import UIKit
import SnapKit
import Components

extension PWManager {
    
    class BasePricePlanView: UIView {
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        lazy var shadowView: UIView = {
            let res = UIView()
            res.backgroundColor = .white
            res.cornerRadius = 10
            return res
        }()
        
        lazy var borderView = UIImageView()
        lazy var priceLab = UILabel()
        lazy var priceAveLab = UILabel()
        lazy var freeLab = UILabel()
        lazy var desLab = UILabel()
        lazy var saveLayer: UIView = {
            let res = UIView()
            res.addSubview(saleLab)
            res.backgroundColor = .red
            res.cornerRadius = cX(12)
            saleLab.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(cX(8))
                make.right.equalToSuperview().offset(-cX(8))
                make.top.bottom.equalToSuperview()
            }
            res.isHidden = true
            return res
        }()
        lazy var saleLab: UILabel = {
            let res = UILabel(frame: .zero, text: "SAVE 80%", textColor: nil, textAligment: .center)
            return res
        }()
        
        var priceGradientColor: (from: UIColor, to: UIColor)?
        
        var selected: Bool = false {
            didSet {
                shadowView.layer.shadow(
                    color: .init(white: 0, alpha: selected ? 0 : 0.12),
                    radius: 4,
                    offset: .init(width: 0, height: 0),
                    opacity: 1
                )
                borderView.isHidden = !selected
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            if let c = priceGradientColor {
                priceAveLab.setGradient(with: [c.from.cgColor, c.to.cgColor])
            }
            shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        }
        
        let product: PWManager.PaywallModel.ProductType
        
        init<T: PWManagerImageProtocol>(_ product: PWManager.PaywallModel.ProductType, _ R: PWManager.PaywallView.Resources<T>) {
            self.product = product
            super.init(frame: .zero)
            
            setupUI()
            
            priceLab.textAlignment = .left
            priceLab.font = R.font("Poppins-SemiBold", fontSize: cIpad(20, 15))
            priceLab.textColor = UIColor(hexString: "#323233")
            
            priceAveLab.textAlignment = .right
            priceAveLab.font = R.font("Poppins-SemiBold", fontSize: cIpad(20, 15))
            priceAveLab.textColor = UIColor(hexString: "#323233")
            
            freeLab.textAlignment = .left
            freeLab.textColor = UIColor(hexString: "#646466")
            freeLab.font = R.font("Poppins-Medium", fontSize: cIpad(17, 13))
            
            desLab.textAlignment = .right
            desLab.textColor = UIColor(hexString: "#646466")
            desLab.font = R.font("Poppins-Medium", fontSize: cIpad(14, 11))
            
            saveLayer.backgroundColor = UIColor(hexString: "E4277A")
            saleLab.font = R.font("Poppins-Medium", fontSize: cX(11))
            saleLab.text = "SAVE 70%"
            saleLab.textColor = .white
            
            let num: Double
            switch product.unit {
            case .year:
                priceLab.text = "Annually-\(product.priceSymbol)\(product.price)/year"
                num = 53.0
            case .month:
                priceLab.text = "Monthly-\(product.priceSymbol)\(product.price)/month"
                num = 4.0
            case .quarter:
                priceLab.text = "Quarterly-\(product.priceSymbol)\(product.price)/3months"
                num = 13.0
            case .week:
                priceLab.text = "Weekly-\(product.priceSymbol)\(product.price)/week"
                num = 1.0
            }
            priceAveLab.text = String(format: "\(product.priceSymbol)%.2f", product.price / num)
            if product.freeTrialDays > 0 {
                freeLab.text = R.string("<p>-Day Free Trial", keys: ["\(product.freeTrialDays)"])
            } else {
                freeLab.text = ""
            }
            desLab.text = R.string("per week")
        }
        
        func setupUI() {
            addSubview(shadowView)
            shadowView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            addSubview(borderView)
            borderView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            addSubview(priceLab)
            addSubview(priceAveLab)
            addSubview(freeLab)
            addSubview(desLab)
            addSubview(saveLayer)
            priceLab.snp.makeConstraints { make in
                make.left.equalTo(cIpad(24, 16))
                make.top.equalTo(cIpad(24, 18))
                make.height.equalTo(cIpad(30, 23))
            }
            priceAveLab.snp.makeConstraints { make in
                make.right.equalTo(-cIpad(24, 18))
                make.centerY.equalTo(priceLab)
            }
            freeLab.snp.makeConstraints { make in
                make.left.equalTo(priceLab)
                make.top.equalTo(priceLab.snp.bottom).offset(cX(4))
                make.height.equalTo(cIpad(26, 20))
            }
            desLab.snp.makeConstraints { make in
                make.right.equalTo(-cIpad(24, 16))
                make.top.equalTo(priceLab.snp.bottom).offset(cX(4))
            }
            saveLayer.snp.makeConstraints { make in
                make.right.equalTo(-cIpad(18, 14))
                make.centerY.equalTo(self.snp.top)
                make.height.equalTo(cX(24))
            }
        }
        
    }
    
}
