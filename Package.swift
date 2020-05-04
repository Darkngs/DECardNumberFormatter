// swift-tools-version:5.2

import PackageDescription

let package = Package(
   name: "DECardNumberFormatter",
   products: [
      .library(name: "DECardNumberFormatter", targets: ["DECardNumberFormatter"])
   ],
   targets: [
      .target(name: "DECardNumberFormatter", dependencies: [])
   ],
   swiftLanguageVersions: [.v5]
)
