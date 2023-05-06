import Foundation
extension PWManager.OOG104_example: PWManagerImageProtocol {
	var R: Resources<PWManager.OOG104_example> {
		return Resources<PWManager.OOG104_example>(bundle: Self.resBundle, language: dataModel.language, font: dataModel.fontConfig)
	}
	public struct Image: PWManagerImageDataType {
		static var bundle: PWManager.PaywallView.Type = PWManager.OOG104_example.self
		static var OnboardingStar: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }
		static var onboarding_shen_bgImage: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }
		static var onboarding_paywall_close: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }
		static var subscription_shen_rect: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }
		static var subscription_shen_secured: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }
	}
}
