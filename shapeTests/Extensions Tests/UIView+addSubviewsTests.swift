import XCTest
@testable import shape

class UIViewAddSubviewsTests: XCTestCase {
    
    func testAddSubviewsWorksCorrectly() {
        let parentView = UIView()
        XCTAssertTrue(parentView.subviews.isEmpty)
        
        parentView.addSubviews(UIView(), UIView())
        
        XCTAssertEqual(parentView.subviews.count, 2)
    }
}
