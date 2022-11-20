import AppLovinSDK
import UIKit
import SwiftUI

public struct AppLovinRepresentable {

    public struct MAADNativeView: UIViewRepresentable {
        public let nativeAdView: MANativeAdView

        public func makeUIView(context: Context) -> MANativeAdView {
            return nativeAdView
        }

        public func updateUIView(_ uiView: MANativeAdView, context: Context) { }
    }

    @available (iOS 14, *)
    public struct MAADBannerView: UIViewRepresentable {

        public let backgroundColor: Color
        public let adUnitID: String

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
        public let adUnitID: String

        public static let shared = AppLovinViewDelegate()
        private override init() { super.init() }

        // MARK: Banner Ads
        public func didExpand(_ ad: MAAd) { }

        public func didCollapse(_ ad: MAAd) { }

        public func didLoad(_ ad: MAAd) { }

        public func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) { }

        public func didDisplay(_ ad: MAAd) { }

        public func didHide(_ ad: MAAd) { }

        public func didClick(_ ad: MAAd) { }

        public func didFail(toDisplay ad: MAAd, withError error: MAError) { }
    }

    open class NativeAdViewDelegate: NSOjbect, MANativeAdDelegate {
        // MARK: faux singleton
        private static var isInitialized: Bool = false

        public let adUnitID: String
        public static let shared = NativeAdViewDelegate()

        init?(adUnitID: String) {
            guard !Self.isInitialized else { return nil }
            super.init()
            self.adUnitID = adUnitID
            nativeAdLoader.nativeAdDelegate = self
            Self.isInitialized = true
        }

        // MARK: Native Ads
        public private(set) let nativeAdLoader: MANativeAdLoader = MANativeAdLoader(adUnitIdentifier: adUnitID)
        public private(set) var nativeAd: MAAd?
        public var nativeAdView: MANativeAdView = .init()

        public func createNativeAd() {
            nativeAdLoader.loadAd()
        }

        public func didLoadNativeAd(_ nativeAdView: MANativeAdView?, for ad: MAAd) {
            // Clean up any pre-existing native ad to prevent memory leaks
            if let currentNativeAd = nativeAd {
                nativeAdLoader.destroy(currentNativeAd)
            }

            // Save ad for cleanup
            nativeAd = ad

            if let nativeAdView = nativeAdView {
                self.nativeAdView = nativeAdView
            }
        }

        public func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) { }

        public func didClickNativeAd(_ ad: MAAd) { }

        deinit {
            nativeAd = nil
        }
    }
}
