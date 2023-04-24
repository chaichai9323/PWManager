/*
 添加UI布局代码,页面中需要用的各种信息以及资源见下边
 1.获取图片资源方法: R.image(named: xx)
 2.获取文本本地化方法: R.string(str)
 3.获取资源路径方法: R.filePath(file)
 4.获取字体的方法: R.font("Poppins-Regular", fontSize: 20)
 5.获取产品列表方法: self.products
 */
import Foundation
import SnapKit
import Components
extension PWManager {
    public class OOG104_sample001: PaywallView {
        override public func setupUI() {
            super.setupUI()
            backgroundColor = .white

#if DEBUG
            backgroundColor = .white
            let btn = UIButton()
            btn.setTitle(R.string(String(describing: type(of: self))), for: .normal)
            btn.setTitleColor(.red, for: .normal)
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
