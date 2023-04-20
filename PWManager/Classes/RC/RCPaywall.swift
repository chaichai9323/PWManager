//
//  RCPaywall.swift
//  PWManager
//
//  Created by chaichai on 2023/4/19.
//

import Foundation
import IAPManager
import RC
import FIREvents

extension PWManager {
    public static func config<T: PaywallView>(design: String, products: [PaywallModel.ProductType], source: String, ui: T.Type, animate: Bool = true) -> RCPaywall {
        return RCPaywall(design: design, products: products, source: source, ui: ui, animate: animate)
    }
}

//MARK: - Model
extension PWManager {
    public class RCPaywall: PaywallModel {
        ///购买的回调
        private(set) var buyHandle: ((_ result: PurchaseResult) -> Void)?
        ///恢复的回调
        private(set) var restoreHandle: ((_ result: PurchaseResult) -> Void)?
        ///页面消失的回调
        private(set) var dismissHandle: ((_ clickClose: Bool) -> Void)?
        
        var _rcProductIDS: [String] {
            let res = products.map{ $0.productIdentifier }
            return res
        }
        
        ///购买
        public func buy(_ handler: ((_ result: PurchaseResult) -> Void)?) -> Self {
            self.buyHandle = handler
            return self
        }
        
        ///恢复
        public func restore(_ handler: ((_ result: PurchaseResult) -> Void)?) -> Self {
            self.restoreHandle = handler
            return self
        }
        
        ///页面消失
        public func dismiss(_ handler: ((_ clickClose: Bool) -> Void)?) -> Self {
            self.dismissHandle = handler
            return self
        }
        
        ///发送事件
        func sendEvent(type: FIREvents.IAPManager_Revenue) {
            IAPManager.shared.sendPaywallTrigerEvent(
                designId: design,
                productIDs: _rcProductIDS,
                paywallSource: .other(name: source),
                eventsType: type
            )
        }
    }
}

