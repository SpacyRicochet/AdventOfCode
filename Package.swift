// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        
        // 2021 solutions
        .library(
            name: "AdventOfCode2021",
            targets: ["AdventOfCode2021"]),
        .executable(
            name: "advent2021",
            targets: ["Advent2021"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        
        // 2021 solutions
        .target(
            name: "AdventOfCode2021",
            dependencies: [],
            resources: [
                .copy("Day 1/day1.txt"),
                .copy("Day 2/day2.txt"),
                .copy("Day 3/day3.txt"),
                .copy("Day 4/day4.txt"),
            ]),
        .testTarget(
            name: "AdventOfCode2021Tests",
            dependencies: ["AdventOfCode2021"]),
        .executableTarget(
            name: "Advent2021",
            dependencies: ["AdventOfCode2021"]),
        .testTarget(
            name: "Advent2021Tests",
            dependencies: ["Advent2021"]),
    ]
)
