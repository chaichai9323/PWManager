//
//  PWManager.swift
//  PWManager
//
//  Created by chaichai on 2023/4/19.
//

import Foundation
import UIKit

//MARK: - Model
public class PWManager {
    
    ///内购产品模型
    public struct ProductModel: Equatable {
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.productIdentifier == rhs.productIdentifier
        }
        
        public enum Period {
            case week
            case month
            case quarter
            case year
        }
        ///产品ID
        let productIdentifier: String
        ///产品周期
        let unit: Period
        ///价格
        let price: Double
        ///价格符号
        let priceSymbol: String
        ///免费天数
        let freeTrialDays: Int
        ///附加数据可以供外部捕获传入的元数据
        public var extraData: Any?
        
        public init(productIdentifier: String, unit: Period, price: Double, freeTrialDays: Int = 7, priceSymbol: String = "$") {
            self.productIdentifier = productIdentifier
            self.unit = unit
            self.price = price
            self.freeTrialDays = freeTrialDays
            self.priceSymbol = priceSymbol
        }
    }
    
    ///Products模型
    public class PaywallModel {
        
        deinit {
            print("\(String(describing: type(of: self))) dealloc")
        }
        
        public typealias ProductType = ProductModel
        ///设计样式。比如 iq9du
        let design: String
        ///产品列表
        let products: [ProductType]
        ///展示的来源。比如 onboarding、lockedMusic 等等
        let source: String
        ///页面类型
        let viewType: PaywallView.Type
        /// 是否需要动画
        fileprivate let animate: Bool
        ///语言环境 比如 [en, es-MX, nl, de]
        fileprivate var language: String?
        ///字体设置
        private(set) var fontConfig: ((_ name: String, _ size: CGFloat) -> UIFont?)?
        ///预留附加信息
        private(set) var extraData: Any?
        ///预留的自定义操作
        private(set) var customHandle: ((Any) -> Void)?
        
        init(design: String, products: [ProductType], source: String, ui: PaywallView.Type, animate: Bool = true) {
            self.design = design
            self.products = products
            self.source = source
            self.viewType = ui
            self.animate = animate
        }
        
        /// 添加额外附加的信息
        /// - Parameter data: 需要在内部
        /// - Returns: 当前对象
        public func addExtraData(_ data: Any) -> Self {
            extraData = data
            return self
        }
        
        /// 切换语言环境, 可选实现，默认是跟随系统语言环境
        /// - Parameter language: 指定的语言比如 [en, es-MX, nl, de ...]
        /// - Returns: 当前对象
        public func switchLanguage(language: String) -> Self {
            self.language = language
            return self
        }
        
        
        /// paywall ui里边需要的字体
        /// - Parameter font: 获取对应字体的闭包  (字体名字,字体大小) -> 字体
        /// - Returns: 当前对象
        public func textFont(_ font: ((_ name: String, _ size: CGFloat) -> UIFont?)?) -> Self {
            self.fontConfig = font
            return self
        }
        
        /// 预留的自定义操作
        /// - Parameter callback: 需要外部处理的操作
        /// - Returns: 当前对象
        public func customAction(_ callback: ((Any) -> Void)?) -> Self {
            self.customHandle = callback
            return self
        }
        
        /// 模态展示
        /// - Parameters:
        ///   - parent: 父ViewController
        ///   - ui: ui配置信息，比如是否需要动画，购买的时候展示的风火轮颜色等等
        public func present(in parent: UIViewController, ui: ((_ config: inout PaywallUIModel) -> Void)? = nil) {
            var congif = PaywallUIModel()
            ui?(&congif)
            let vc = PaywallViewController(model: self, ui: congif)
            parent.present(vc, animated: congif.animate)
        }
        
        /// push方式展示
        /// - Parameters:
        ///   - nav: 展示paywall的UINavigationController
        ///   - ui: ui配置信息，比如是否需要动画，购买的时候展示的风火轮颜色等等
        public func push(with nav: UINavigationController, ui: ((_ config: inout PaywallUIModel) -> Void)? = nil) {
            var congif = PaywallUIModel()
            ui?(&congif)
            let vc = PaywallViewController(model: self, ui: congif)
            nav.pushViewController(vc, animated: true)
        }
    }
    
    ///UI 配置
    public struct PaywallUIModel {
        public enum Style {
            case push
            case present(modal: UIModalPresentationStyle)
        }
        ///是否需要弹出动画
        public var animate: Bool = true
        ///展示的方式
        public var showStyle: Style = .present(modal: .fullScreen)
        ///加载动画颜色
        public var loadingActivityColor: UIColor = .white
        ///加载蒙层颜色
        public var loadingCoverColor: UIColor = .init(white: 0, alpha: 0.3)
    }
}

//MARK: - VC
extension PWManager {
    
    class PaywallViewController: UIViewController {
        let paywall: PaywallView
        let uiModel: PaywallUIModel
        
        private lazy var loadingActivity: UIActivityIndicatorView = {
            let res = UIActivityIndicatorView()
            res.activityIndicatorViewStyle = .large
            res.color = uiModel.loadingActivityColor
            res.translatesAutoresizingMaskIntoConstraints = false
            return res
        }()
        
        private lazy var loadingCover: UIView = {
            let res = UIView()
            res.translatesAutoresizingMaskIntoConstraints = false
            res.backgroundColor = uiModel.loadingCoverColor
            res.addSubview(loadingActivity)
            loadingActivity.centerXAnchor.constraint(equalTo: res.centerXAnchor).isActive = true
            loadingActivity.centerYAnchor.constraint(equalTo: res.centerYAnchor).isActive = true
            return res
        }()
        
        var loading: Bool {
            set {
                loadingCover.isHidden = !newValue
                if loadingCover.isHidden {
                    loadingActivity.stopAnimating()
                } else {
                    loadingActivity.startAnimating()
                }
            }
            get {
                !loadingCover.isHidden
            }
        }
        
        deinit {
            print("PaywallViewController dealloc")
        }
        
        init(model: PaywallModel, ui: PaywallUIModel) {
            paywall = model.viewType.init(model)
            uiModel = ui
            super.init(nibName: nil, bundle: nil)
            switch ui.showStyle {
            case .present(let modal): modalPresentationStyle = modal
            default: break
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(loadingCover)
            loadingCover.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            loadingCover.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            loadingCover.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            loadingCover.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loading = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func loadView() {
            view = paywall
        }
        
        internal func back() {
            switch uiModel.showStyle {
            case .present: dismiss(animated: uiModel.animate)
            case .push: navigationController?.popViewController(animated: uiModel.animate)
            }
        }
    }
}

extension PWManager.PaywallView {
    
    struct Resources {
        let bundle: Bundle
        let language: String?
        
        private var font: ((_ name: String, _ size: CGFloat) -> UIFont?)?
        
        init(bundle: Bundle, language: String?, font: ((_: String, _: CGFloat) -> UIFont?)? = nil) {
            self.bundle = bundle
            self.language = language
            self.font = font
        }
        
        private var allLanguages: [String] {
            let all = bundle.localizations
            return all
        }
        
        private var specifyBundle: Bundle? {
            guard let lan = language,
                  let path = bundle.path(forResource: lan, ofType: "lproj"),
                  let b = Bundle(path: path) else {
                return nil
            }
            return b
        }
        
        private var localBundle: Bundle? {
            if let b = specifyBundle {
                return b
            }
            let proj: String
            if let lan = allLanguages.filter({ Locale.current.identifier.hasPrefix($0) }).first {
                proj = lan
            } else {
                proj = "Base"
            }
            guard let path = bundle.path(forResource: proj, ofType: "lproj") else {
                return nil
            }
            return Bundle(path: path)
        }
        
        func image(named: String) -> UIImage? {
            return UIImage(named: named, in: bundle, compatibleWith: nil)
        }
        
        func filePath(_ name: String) -> String? {
            if let p = localBundle?.path(forResource: name, ofType: nil) {
                return p
            }
            return bundle.path(forResource: name, ofType: nil)
        }
        
        func string(_ str: String) -> String {
            if let p = localBundle {
                return p.localizedString(forKey: str, value: nil, table: nil)
            }
            return bundle.localizedString(forKey: str, value: nil, table: nil)
        }
        
        func font(_ fontName: String, fontSize: CGFloat) -> UIFont {
            guard let fnt = font?(fontName, fontSize) else {
                return UIFont.systemFont(ofSize: fontSize)
            }
            return fnt
        }
    }
    
    var R: Resources {
        guard let b = resBundle else { return Resources(bundle: .main, language: nil) }
        return Resources(bundle: b, language: dataModel.language)
    }
    
    fileprivate var resBundle: Bundle? {
        let clsName = String(describing: type(of: self))
        guard let start = clsName.firstIndex(of: "_") else { return nil }
        let paywallID = clsName[start ..< clsName.endIndex]
        guard let path = Bundle.main.path(forResource: "PWManager\(String(paywallID))", ofType: "bundle") else {
            return nil
        }
        
        return Bundle(path: path)
    }
}
