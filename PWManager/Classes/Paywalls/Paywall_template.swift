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
    public class Paywall_template: PaywallView {
        override public func setupUI() {
            super.setupUI()
            backgroundColor = .white

            let lab = UILabel()
            lab.textColor = .red
            lab.font = R.font("Poppins-Regular", fontSize: 22)
            lab.text = R.string("UI布局")
            addSubview(lab)
            lab.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
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
