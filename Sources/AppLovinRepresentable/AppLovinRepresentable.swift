import AppLovinSDK
import UIKit
import SwiftUI

public struct AppLovinRepresentable {

    @available (iOS 14, *)
    public struct MAADBannerView: UIViewRepresentable {

        public let backgroundColor: Color
        public let adUnitID: String

        public init(backgroundColor: Color, adUnitID: String) {
            self.backgroundColor = backgroundColor
            self.adUnitID = adUnitID
        }

        public func makeUIView(context: Context) -> MAAdView {
            let view = MAAdView(adUnitIdentifier: adUnitID)
            view.backgroundColor = UIColor(backgroundColor)
            view.delegate = AppLovinViewDelegate.shared
            view.loadAd()
            return view
        }

        public func updateUIView(_ uiView: MAAdView, context: Context) { }
    }
    
    open class AppLovinViewDelegate: NSObject, MAAdViewAdDelegate {

        public static let shared = AppLovinViewDelegate()
        private override init() { super.init() }

        // MARK: Banner Ads
        open func didExpand(_ ad: MAAd) { }

        open func didCollapse(_ ad: MAAd) { }

        open func didLoad(_ ad: MAAd) { }

        open func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) { }

        open func didDisplay(_ ad: MAAd) { }

        open func didHide(_ ad: MAAd) { }

        open func didClick(_ ad: MAAd) { }

        open func didFail(toDisplay ad: MAAd, withError error: MAError) { }
    }
}
