// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppLovinRepresentable",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppLovinRepresentable",
            targets: ["AppLovinRepresentable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppLovinRepresentable",
            dependencies: [.product(name: "AppLovinSDK", package: "AppLovin-MAX-Swift-Package")]),
        .testTarget(
            name: "AppLovinRepresentableTests",
            dependencies: ["AppLovinRepresentable"]),
    ]
)

