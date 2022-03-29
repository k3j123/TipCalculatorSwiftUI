import XCTest
@testable import TipCalculatorSwiftUI

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavoir

// Testing Structure: Given, When, Then

class TipCalculatorViewModel_Tests: XCTestCase {
    let vm = TipCalculatorViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TipCalculatorViewModel_tip_shouldBeNil() throws {
        XCTAssertNil(vm.tip)
    }

    func test_TipCalculatorViewModel_calculateTip_shouldReturnTrue() throws {
        vm.principleAmount = 1000.0
        vm.selectedTipIndex = 0
        
        // tip = (10 / 100) * 1000.0 = 150.0
        vm.calculateTip()
        
        XCTAssertTrue(vm.tip == 150.0)
    }
    
    func test_TipCalculatorViewModel_calculateTipPerGuest_shouldReturnTrue() throws {
        vm.principleAmount = 1000.0
        vm.guests = 2
        vm.selectedTipIndex = 0
        
        // tip = (10 / 100) * 1000.0 = 150.0 / 2 = 75
        vm.calculateTip()
        
        XCTAssertTrue(vm.tipPerGuest == 75.0)
    }
    
    func test_TipCalculatorViewModel_calculateTipTotal_shouldReturnTrue() throws {
        vm.principleAmount = 1000.0
        vm.selectedTipIndex = 0
        
        // tip = (10 / 100) * 1000.0 = 150.0 + 1000.0 = 1150.0
        vm.calculateTip()
        
        XCTAssertTrue(vm.totalAmount == 1150.0)
    }
}
