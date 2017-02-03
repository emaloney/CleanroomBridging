import PackageDescription

let package = Package(
    name: "CleanroomBridging",
    targets: [
        Target(name: "CleanroomBridging_ObjC"),
        Target(name: "CleanroomBridging", dependencies: ["CleanroomBridging_ObjC"])
    ]
)
