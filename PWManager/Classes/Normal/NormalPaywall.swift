//
//  NormalPaywall.swift
//  PWManager
//
//  Created by chaichai on 2023/4/19.
//

import Foundation

extension PWManager {
    public static func config<T: PaywallView>(design: String, products: [PaywallModel.ProductType], source: String, ui: T.Type, animate: Bool = true) -> NormalPaywall {
        return NormalPaywall(design: design, products: products, source: source, ui: ui, animate: animate)
    }
}

//MARK: - Model
extension PWManager {
    public class NormalPaywall: PaywallModel {
        public typealias CallbackType = ((_ suc: Bool) -> Void)?
        ///购买的回调
        private(set) var buyHandle: ((_ product: ProductType, _ complete: CallbackType) -> Void)?
        ///恢复的回调
        private(set) var restoreHandle: ((_ complete: CallbackType) -> Void)?
        ///页面消失的回调
        private(set) var dismissHandle: ((_ clickClose: Bool) -> Void)?
        
        ///购买
        public func buy(_ handler: ((_ product: ProductType, _ complete: CallbackType) -> Void)?) -> Self {
            self.buyHandle = handler
            return self
        }
        
        ///恢复
        public func restore(_ handler: ((_ complete: CallbackType) -> Void)?) -> Self {
            self.restoreHandle = handler
            return self
        }
        
        ///页面消失
        public func dismiss(_ handler: ((_ clickClose: Bool) -> Void)?) -> Self {
            self.dismissHandle = handler
            return self
        }
        
    }
}


