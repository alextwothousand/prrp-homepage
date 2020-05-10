// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "prrp-homepage",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.8.0"),
        .package(name: "KituraStencil", url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", from: "1.11.1"),
        .package(name: "SwiftKuery", url: "https://github.com/IBM-Swift/Swift-Kuery.git", from: "3.0.1"),
        .package(name: "SwiftKueryMySQL", url: "https://github.com/IBM-Swift/SwiftKueryMySQL.git", from: "2.0.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "prrp-homepage",
            dependencies: ["Kitura", "KituraStencil", "SwiftKuery", "SwiftKueryMySQL"]),
        .testTarget(
            name: "prrp-homepageTests",
            dependencies: ["prrp-homepage"]),
    ]
)
