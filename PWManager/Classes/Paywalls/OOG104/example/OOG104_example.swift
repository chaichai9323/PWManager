import Foundation
import SnapKit
import Components
extension PWManager {
    public class OOG104_example: PaywallView {
        
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
