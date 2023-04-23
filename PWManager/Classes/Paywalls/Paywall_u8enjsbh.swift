//
//  Paywall_u8enjsbh.swift
//  PWManager
//
//  Created by chaichai on 2023/4/20.
//

import Foundation
import SnapKit

extension PWManager {
    public class Paywall_u8enjsbh: PaywallView {
        public override func setupUI() {
            super.setupUI()
            
            backgroundColor = .lightGray
            
            loadDemoTitle()
            loadProducts()
            loadClose()
        }
        
        private func loadDemoTitle() {
            let lab = UILabel()
            lab.textColor = .red
            lab.font = self.font(fontName: "Poppins-SemiBoldItalic", fontSize: 22)
            lab.text = "Demo"
            addSubview(lab)
            lab.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            }
        }
        
        private func loadProducts() {
            for (i, p) in products.enumerated() {
                let lab = UILabel()
                lab.isUserInteractionEnabled = true
                lab.textAlignment = .center
                lab.backgroundColor = .cyan
                lab.tag = i
                let num: Double
                switch p.unit {
                case .year: num = 53.0
                case .quarter: num = 13.0
                case .month: num = 4.0
                case .week: num = 1.0
                }
                
                let weekPrice = String(format: "\(p.priceSymbol)%.2f", p.price / num)
                
                lab.font = self.font(fontName: "Poppins-Regular", fontSize: 16)
                lab.text = "\(p.priceSymbol)\(p.price)" + "   " + weekPrice + "/" + self.localString("txt-351")
                
                addSubview(lab)
                lab.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalToSuperview().offset(200 + i * 80)
                }
                let ges = UITapGestureRecognizer(target: self, action: #selector(buy(_:)))
                lab.addGestureRecognizer(ges)
            }
        }
        
        private func loadClose() {
            let btn = UIButton()
            btn.setImage(image(named: "onboarding_paywall_close"), for: .normal)
            btn.addTarget(self, action: #selector(close), for: .touchUpInside)
            addSubview(btn)
            btn.snp.makeConstraints { make in
                make.size.equalTo(40)
                make.left.equalToSuperview().offset(20)
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            }
            
            let btn2 = UIButton(type: .infoDark)
            btn2.addTarget(self, action: #selector(customAction), for: .touchUpInside)
            addSubview(btn2)
            btn2.snp.makeConstraints { make in
                make.size.equalTo(40)
                make.right.equalToSuperview().offset(-20)
                make.top.equalTo(btn)
            }
        }
        
        @objc func customAction() {
            self.paywallHandleCustomAction(param: "自定义参数")
        }
        
        @objc func buy(_ ges: UITapGestureRecognizer) {
            guard let lab =  ges.view else { return }
            self.paywallActionBuy(product: products[lab.tag])
        }
        
        @objc func close() {
            self.paywallActionClose()
        }
        
    }
}
