//
//  DownloadDataManagerTests.swift
//  Weather displayerTests
//
//  Created by Federico Imberti on 12/02/22.
//

import XCTest
@testable import Weather_displayer

class DownloadDataManagerTests: XCTestCase {

	let downloadDataManager = DownloadDataManager(isForTesting: true)
	
	func test_DownloadDataManager_createUrlRequest_theUrlRequestIsCreated(){
		//Given
		let correctRequest = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Cazzanosant'Andrea/next7days?unitGroup=metric&include=days&key=AZSUM3BTUUFQD2FRU4T8ZR6MQ&contentType=json"
		
		//When
		let urlRequest = downloadDataManager.createUrlRequest(for: "Cazzano sant'Andrea")
		
		//Then
		XCTAssertEqual(urlRequest, correctRequest)
		
	}

}
