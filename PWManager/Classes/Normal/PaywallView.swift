//
//  PaywallView.swift
//  PWManager
//
//  Created by chaichai on 2023/4/19.
//

import Foundation

//MARK: - View
extension PWManager {
    open class PaywallView: UIView {
        let dataModel: PaywallModel
        
        ///Paywall页面所有产品列表
        public var products: [PaywallModel.ProductType] { dataModel.products }
        
        deinit {
            print("\(String(describing: type(of: self))) dealloc")
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        required public init(_ model: PaywallModel) {
            dataModel = model
            super.init(frame: .zero)
            setupUI()
        }
        
        internal var vc: PaywallViewController? {
            if let res = self.next as? PaywallViewController {
                return res
            }
            return nil
        }
        
        private var myModel: PWManager.NormalPaywall? {
            guard let res = dataModel as? PWManager.NormalPaywall else { return nil }
            return res
        }
        
        ///页面元素布局
        open func setupUI() {

        }
        
        ///购买操作，所有子类统一调用此方法进行购买不要自己实现
        public final func paywallActionBuy(product: PaywallModel.ProductType) {
            self.vc?.loading = true
            myModel?.buyHandle?(product) { [weak self] suc in
                self?.vc?.loading = false
                if suc {
                    self?.vc?.back()
                    self?.myModel?.dismissHandle?(false)
                }
            }
        }
        
        ///恢复操作，所有子类统一调用此方法进行购买，不要自己实现
        public final func paywallActionRestore() {
            self.vc?.loading = true
            myModel?.restoreHandle?{ [weak self] suc in
                self?.vc?.loading = false
                if suc {
                    self?.vc?.back()
                    self?.myModel?.dismissHandle?(false)
                }
            }
        }
        
        ///自定义操作
        public final func paywallHandleCustomAction(param: Any) {
            dataModel.customHandle?(param)
        }
        
        ///关闭动作
        public final func paywallActionClose() {
            vc?.back()
            myModel?.dismissHandle?(true)
        }
    }
}
