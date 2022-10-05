//
//  UnitTestingBootcampViewModel_Tests.swift
//  SwiftUIAdvancedLearning_Tests
//
//  Created by Joel Bearn on 04/10/2022.
//

import XCTest
@testable import SwiftUIAdvancedLearning
import Combine

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]

// Testing Structure: Given, When, Then

class UnitTestingBootcampViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingBootcampViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue(){
        // Given
        let userIsPremium: Bool = true
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse(){
        // Given
        let userIsPremium: Bool = false
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue(){
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress(){
        for _ in 0..<10{
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty(){
        //Given
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItems(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)

    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString2(){
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)

    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_initialisedAsNil(){
        //Given
        
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertNil(vm.selectedItem)

    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        // First Select Valid Item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        // Then Select Invalid Item
        vm.selectItem(item: UUID().uuidString)
        
        
        //Then
        XCTAssertNil(vm.selectedItem)

    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int  = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount{
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_itemNotFound(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int  = Int.random(in: 1..<100)
        for _ in 0..<loopCount{
            vm.addItem(item: UUID().uuidString)
        }

        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "should throw Item Not Found error") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_noData(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int  = Int.random(in: 1..<100)
        for _ in 0..<loopCount{
            vm.addItem(item: UUID().uuidString)
        }

        
        //Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
        
        //Alternative
        XCTAssertThrowsError(try vm.saveItem(item: ""))
        XCTAssertThrowsError(try vm.saveItem(item: ""), "should throw no Data error") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldSaveItem(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int  = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount{
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""

        
        //Then
        XCTAssertFalse(randomItem.isEmpty)
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
        
    }
    
    func test_UnitTestingBootcampViewModel_downloadWithEscaping_shouldReturnItems(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
         
        //When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        
        vm.$dataArray
            .dropFirst() // to avoid initialisation publish of []
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        
        vm.downloadWithEscaping()

        //Then
        wait(for: [expectation], timeout: 4)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        
    }
    
    func test_UnitTestingBootcampViewModel_downloadWithCombine_shouldReturnItems(){
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
         
        //When
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst() // to avoid initialisation publish of []
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        
        vm.downloadWithCombine()

        //Then
        wait(for: [expectation], timeout: 3)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        
    }
    
    
}
