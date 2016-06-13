import XCTest
@testable import SpeckCoreTestSuite
@testable import SpeckAssertsTestSuite

XCTMain([
    // SpeckCoreTestSuite
    testCase(BasicExpectationTest.allTests),
    testCase(ExampleTest.allTests),
    testCase(ReporterTest.allTests),
    testCase(SuiteTest.allTests),

    // SpeckAssertsTestSuite
    testCase(ArrayTest.allTests),
    testCase(CollectionTest.allTests),
    testCase(ComparableTest.allTests),
    testCase(ExpectationTest.allTests)
])
