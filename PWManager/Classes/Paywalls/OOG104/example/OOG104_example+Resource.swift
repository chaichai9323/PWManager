import Foundation
extension PWManager.OOG104_example: PWManagerImageProtocol {
	var R: Resources<PWManager.OOG104_example> {
		return Resources<PWManager.OOG104_example>(bundle: Self.resBundle, language: dataModel.language, font: dataModel.fontConfig)
	}
	public struct Image: PWManagerImageDataType {
		static var bundle: PWManager.PaywallView.Type = PWManager.OOG104_example.self
		static var onboarding: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }
		static var onboarding_paywall_close: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }
	}
}