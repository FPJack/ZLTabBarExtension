// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZLTabBarExtension",
    
    // 對應 podspec 中的 ios.deployment_target = '10.0'
    platforms: [
        .iOS(.v12),
        // 如果之後要支援 macOS、tvOS 等，可以再加上
        // .macOS(.v10_15),
    ],
    
    products: [
        // 通常會做成 library，名字建議跟 pod 名稱一致
        .library(
            name: "ZLTabBarExtension",
            targets: ["ZLTabBarExtension"]
        ),
    ],
    
    dependencies: [
        // 如果原本 podspec 有 s.dependency 'XXX' 在這裡加
        // 你的 podspec 目前沒有外部依賴，所以這邊留空
        // .package(url: "https://github.com/xxx/yyy.git", from: "1.0.0"),
    ],
    
    targets: [
        .target(
            name: "ZLTabBarExtension",
            dependencies: [],
            path: "ZLTabBarExtension/Classes",
            resources: [
                .process("../Resources/PrivacyInfo.xcprivacy")
            ]
        ),
        
    ]
)
