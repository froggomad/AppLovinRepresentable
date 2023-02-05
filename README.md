# AppLovinRepresentable
### Banner Ads in SwiftUI

`Usage:`
```swift
final class AppLovinViewDelegate: NSObject, MAAdViewAdDelegate {  

    static let shared = AppLovinViewDelegate()
    private override init() {
        super.init()
    }    
    
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
        // React to the ad failing to load
    }
}
```
