// swift-tools-version:5.4
import PackageDescription

#if os(iOS) || os(tvOS) || os(watchOS) 
let tools:[Product] = []
let executables:[Target] = []
#else 
let tools:[Product] = 
[
    .executable(name: "crc-tests",  targets: ["CRCTests"]),
    .executable(name: "sha2-tests", targets: ["SHA2Tests"]),
]
let executables:[Target] = 
[
    .executableTarget(name: "CRCTests", 
        dependencies: 
        [
            .target(name: "CRC"),
        ],
        path: "Tests/CRC"),
    .executableTarget(name: "SHA2Tests", 
        dependencies: 
        [
            .target(name: "SHA2"),
        ],
        path: "Tests/SHA2"),
]
#endif 

let package:Package = .init(
    name: "swift-hash",
    products: tools +
    [
        .library(name: "Base16",  targets: ["Base16"]),
        .library(name: "SHA2", targets: ["SHA2"]),
        .library(name: "CRC", targets: ["CRC"]),
    ],
    dependencies: 
    [
    ],
    targets: executables +
    [
        .target(name: "Base16"),
        .target(name: "SHA2", 
            dependencies: 
            [
                .target(name: "Base16"),
            ]),
        .target(name: "CRC", 
            dependencies: 
            [
                .target(name: "Base16"),
            ]),
    ]
)
