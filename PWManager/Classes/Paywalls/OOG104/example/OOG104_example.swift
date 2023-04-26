import Foundation
import SnapKit
import Components
extension PWManager {
    public class OOG104_example: PaywallView {
        override public func setupUI() {
            super.setupUI()
#if DEBUG
            backgroundColor = .white
            let btn = UIButton()
            btn.backgroundColor = .brown
            btn.setTitle(R.string(String(describing: type(of: self))), for: .normal)
            btn.setTitleColor(.red, for: .normal)
            btn.setImage(R.image.onboarding_paywall_close, for: .normal)
            btn.titleLabel?.font = R.font("Poppins-Regular", fontSize: 22)
            btn.addTarget(self, action: #selector(close), for: .touchUpInside)
            addSubview(btn)
            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            }
#endif
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
