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

    open class NativeAdViewDelegate: NSObject, MANativeAdDelegate {
        // MARK: faux singleton
        private static var isInitialized: Bool = false

        // MARK: Native Ads
        public private(set) var nativeAdView: MANativeAdView = .init()
        public private(set) var nativeAd: MAAd?
        public private(set) static var adUnitID: String? = nil
        public let nativeAdLoader: MANativeAdLoader = MANativeAdLoader(adUnitIdentifier: adUnitID!)

        public init?(adUnitID: String) {
            guard !Self.isInitialized else { return nil }
            super.init()
            Self.adUnitID = adUnitID
            nativeAdLoader.nativeAdDelegate = self
            Self.isInitialized = true
        }

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

        open func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) { }

        open func didClickNativeAd(_ ad: MAAd) { }

        deinit {
            nativeAd = nil
        }
    }
}
