// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "TwitterSpacesSearch",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "TwitterService", targets: ["TwitterService"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections.git", from: "0.0.1"),
  ],
  targets: [
    .target(name: "AppFeature", dependencies: ["TwitterService", .product(name: "OrderedCollections", package: "swift-collections")]),
    .target(name: "TwitterService", dependencies: ["APIClient", "TwitterModels"]),
    .target(name: "APIClient", dependencies: []),
    .target(name: "TwitterModels", dependencies: []),

    .testTarget(name: "TwitterSpacesSearchTests", dependencies: ["AppFeature"]),
  ]
)
