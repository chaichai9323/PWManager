import Foundation
import SnapKit
import Components
extension PWManager {
    public class OOG104_example: PaywallView {
        class ExamplePlan: BasePricePlanView {
            init(_ product: PWManager.PaywallModel.ProductType, _ R: PWManager.PaywallView.Resources<OOG104_example>) {
                super.init(frame: .zero)
                
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
                freeLab.text = R.string("<p>-Day Free Trial", keys: ["\(product.freeTrialDays)"])
                desLab.text = R.string("per week")
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
        
        lazy var starView: UIStackView = {
            let stack = UIStackView()
            stack.spacing = cIpad(8, 4)
            stack.axis = .horizontal
            stack.alignment = .leading
            stack.distribution = .equalSpacing
            let w = cIpad(47, 25)
            for _ in 0 ..< 5 {
                let img = UIImageView(image: R.image.OnboardingStar)
                img.widthAnchor.constraint(equalToConstant: w).isActive = true
                img.heightAnchor.constraint(equalToConstant: w).isActive = true
                stack.addArrangedSubview(img)
            }
            return stack
        }()
        
        var planViews: [ExamplePlan] = []
        
        override public func setupUI() {
            super.setupUI()
            backgroundColor = .white
            let bgImageView = UIImageView(image: R.image.onboarding_shen_bgImage)
            addSubview(bgImageView)
            bgImageView.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(cIpad(412, 317, 222))
            }
            
            let closeBtn = UIButton(image: R.image.onboarding_paywall_close, target: self, action: #selector(close))
            addSubview(closeBtn)
            closeBtn.snp.makeConstraints { make in
                make.left.equalTo(cX(16))
                make.top.equalTo(StateBar.barHeight)
                make.width.height.equalTo(44)
            }
            
            let limitedLB = UILabel(frame: .zero, text: R.string("Join thousands of happy users"), textColor: UIColor(hexString: "323233"), font: R.font("Poppins-SemiBold", fontSize: cIpad(23, 20)), textAligment: .center)
            addSubview(limitedLB)
            limitedLB.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(cX(16))
                make.top.equalTo(bgImageView.snp.bottom).offset(cIpad(18, 27, 24))
                make.height.equalTo(cIpad(35, 30))
            }
            addSubview(starView)
            starView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(limitedLB.snp.bottom).offset(cIpad(10, 8, 4))
            }
            loadProducts()
            
            let buyBtn = UIButton()
            buyBtn.cornerRadius = cIpad(32, 24)
            buyBtn.setTitle(R.string("Try Free & Subscribe"), for: .normal)
            buyBtn.setTitleColor(.white, for: .normal)
            buyBtn.addTarget(self, action: #selector(buy), for: .touchUpInside)
            addSubview(buyBtn)
            buyBtn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(cIpad(512, 343))
                make.height.equalTo(cIpad(64, 48))
                make.bottom.equalTo(-cIpad(105, 110, 80))
            }
            buyBtn.makeGradient(
                from: UIColor(hexString: "#FF1850"),
                to: UIColor(hexString: "#8A53FF"),
                start: .init(x: 0.25, y: 0.5),
                end: .init(x: 0.75, y: 0.5)
            )
        }
        
        private func loadProducts() {
            var topView: UIView = starView
            for (i, model) in products.enumerated() {
                let v = ExamplePlan(model,R)
                v.borderView.image = R.image.subscription_shen_rect
                v.saveLayer.isHidden = i != 0
                addSubview(v)
                v.snp.makeConstraints { make in
                    make.width.equalToSuperview().offset(-cIpad(64, 32))
                    make.height.equalTo(cIpad(108, 80))
                    make.centerX.equalToSuperview()
                    if i == 0 {
                        make.top.equalTo(topView.snp.bottom).offset(cX(cIpad(50, 38, 30)))
                    } else {
                        make.top.equalTo(topView.snp.bottom).offset(cIpad(21, 16))
                    }
                    topView = v
                }
                v.layoutIfNeeded()
                if model.unit == .year {
                    v.selected = true
                    v.priceAveLab.gradientColor = (
                        UIColor(hexString: "#FF1850"),
                        UIColor(hexString: "#8A53FF")
                    )
                } else {
                    v.selected = false
                }
                let tap = UITapGestureRecognizer(target: self, action: #selector(selectPlan(_:)))
                v.addGestureRecognizer(tap)
                planViews.append(v)
            }
        }

        @objc private func selectPlan(_ ges: UITapGestureRecognizer) {
            guard let v = ges.view as? BasePricePlanView else {
                return
            }
            planViews.forEach { sub in
                sub.selected = sub == v
            }
        }
        /// 购买方法
        @objc func buy() {
            paywallActionBuy(product: products[0])
        }

        /// 恢复购买方法
        @objc func restore() {
            paywallActionRestore()
        }

        /// 关闭paywall的方法
        @objc func close() {
            paywallActionClose()
        }
        
        ///自定义操作
        @objc func customAction() {
            paywallHandleCustomAction(param: "自定义参数")
        }
    }
}
