import XCTest
@testable import shape

class UIDataPickerEpochTimeTests: XCTestCase {
    
    func testEpochTimeIsCorrect() {
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 11
        dateComponents.day = 2
        dateComponents.hour = 0
        dateComponents.minute = 0

        guard let testDate = Calendar.current.date(from: dateComponents) else {
            XCTFail("Unable to create date from components")
            return
        }
        
        let datePicker = UIDatePicker()
        datePicker.date = testDate
        
        XCTAssertEqual(datePicker.epochTime, 1604271600)
    }
}
