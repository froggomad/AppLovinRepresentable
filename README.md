# AppLovinRepresentable
### Banner Ads and Native Ads in SwiftUI

`Usage:`
```swift
final class AppLovinViewDelegate: NSObject, MAAdViewAdDelegate, MANativeAdDelegate {

    private let nativeAdLoader: MANativeAdLoader = MANativeAdLoader(adUnitIdentifier: "MY_NATIVE_aDIDENTIFIER")
    private var nativeAd: MAAd?
    var nativeAdView: MANativeAdView = .init()

    static let shared = AppLovinViewDelegate()
    private override init() {
        super.init()
        nativeAdLoader.nativeAdDelegate = self
    }
    
    // MARK: Banner Ads
    func didExpand(_ ad: MAAd) { 
      // react to the ad being expanded
    }

    func didCollapse(_ ad: MAAd) { 
      // react to the ad collapsing
    }

    func didLoad(_ ad: MAAd) {
      // react to the ad loading
    }

    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        // react to the ad failing to load
    }

    func didDisplay(_ ad: MAAd) {
        // react to the ad being displayed
    }

    func didHide(_ ad: MAAd) {
        // react to the user hiding the ad
    }

    func didClick(_ ad: MAAd) {
        // react to the user tapping the ad
    }

    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        React to the ad failing to load
    }

    // MARK: Native Ads
    func createNativeAd() {
        nativeAdLoader.loadAd()
    }

    func didLoadNativeAd(_ nativeAdView: MANativeAdView?, for ad: MAAd) {
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

    func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        // react to the native ad failing to load
    }

    func didClickNativeAd(_ ad: MAAd) {
        // react to the user tapping a native ad
    }
}
```
