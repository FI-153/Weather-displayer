//
//  DayTests.swift
//  Weather displayerTests
//
//  Created by Federico Imberti on 12/02/22.
//

import XCTest
@testable import Weather_displayer

class DayTests: XCTestCase {
	
	func test_Day_equals_theDaysAreDifferent(){
		//Given
		let day1 = Day.mockData[0]
		let day2 = Day.mockData[1]
		
		//When
		//Then
		XCTAssertFalse(day1 == day2)
	}
	
	func test_Day_extractDate_theDateIsExtractedInTheExprectedFormat(){
		//Given
		let day = Day.mockData[0]
		
		//When
		//Then
		XCTAssertEqual("01/02", day.datetime)
		
	}
	
	func test_Dat_extractConditions_twoConditionsAreExtracted(){
		//Given
		let day = Day.mockData[0]
		
		//When
		//Then
		XCTAssertEqual(day.conditions![0]!, "Cloudy")
		XCTAssertEqual(day.conditions![1]!, "partially cloudy")
	}
	
	func test_Dat_extractConditions_oneConditionisExtracted(){
		//Given
		let day = Day.mockData[1]
		
		//When
		//Then
		XCTAssertEqual(day.conditions![0]!, "Rain")
		XCTAssertEqual(day.conditions!.count, 1)
	}

}
