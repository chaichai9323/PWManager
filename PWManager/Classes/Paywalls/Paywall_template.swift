/*
 添加UI布局代码
 1.获取图片资源方法: self.image(named: xx)
 2.获取文本本地化方法: self.localString(str)
 3.获取资源路径方法: self.filePath(name: file)
 */
import Foundation
import SnapKit

extension PWManager {
    public class Paywall_template: PaywallView {
        override public func setupUI() {
            super.setupUI()
            backgroundColor = .white

            let lab = UILabel()
            lab.textColor = .red
            lab.font = .boldSystemFont(ofSize: 22)
            lab.text = "UI布局"
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
