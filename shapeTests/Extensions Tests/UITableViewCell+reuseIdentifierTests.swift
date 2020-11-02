import XCTest
@testable import shape

class UITableViewCellReuseIdentifierTests: XCTestCase {
    
    func testReuseIdentifierIsCorrect() {
        XCTAssertEqual(UITableViewCell.reuseIdentifier, "UITableViewCell")
    }
    
}
