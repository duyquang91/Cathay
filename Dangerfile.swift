import Danger
import DangerSwiftCoverage // package: https://github.com/f-meloni/danger-swift-coverage.git

SwiftLint.lint(inline: true)

Coverage.xcodeBuildCoverage(.derivedDataFolder("Build"),
                            minimumCoverage: 90,
                            excludedTargets: ["CathayTests.xctest"])
