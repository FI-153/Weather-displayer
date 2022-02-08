//
//  Weather_displayerTests.swift
//  Weather displayerTests
//
//  Created by Federico Imberti on 08/02/22.
//

import XCTest
@testable import Weather_displayer

class DownloadDataManagerTests: XCTestCase {
	
	var downloadDataManager:DownloadDataManager?
	
	override func setUpWithError() throws {
		downloadDataManager = DownloadDataManager(isForTesting: true)
	}
	
	override func tearDownWithError() throws {
		downloadDataManager = nil
	}
	
	func test_DownloadDataManager_init_theDownloadedWeatherContainsMockData(){
		//Given
		guard let downloadDataManager = downloadDataManager else {
			XCTFail("Cannot initilize downloadDataManager")
			return
		}

		//When
		//Then
		XCTAssertEqual(downloadDataManager.downloadedData, WeatherData.mockData)
	}
	
	func test_DownloadDataManager_init_thePreviouslyDownloadedWeatherIsEmpty(){
		//Given
		//When
		//Then
		XCTAssertNil(downloadDataManager!.previouslyDownloadedData)
	}

	
	
}
