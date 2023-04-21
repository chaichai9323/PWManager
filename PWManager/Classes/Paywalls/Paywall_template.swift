/*
 添加UI布局代码
 获取图片资源方法: self.image(named: xx)
 获取文本本地化方法: self.localString(str)
 获取资源路径方法: self.filePath(name: file)
 */
import Foundation
import SnapKit

extension PWManager {
    public class Paywall_template: PaywallView {
        public override func setupUI() {
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
        ///购买
        @objc func buy() {
            self.paywallActionBuy(product: products[0])
        }
        ///恢复
        @objc func restore() {
            self.paywallActionRestore()
        }
        ///关闭
        @objc func close() {
            self.paywallActionClose()
        }
    }
}
