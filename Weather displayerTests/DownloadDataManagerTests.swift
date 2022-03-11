//
//  DownloadDataManagerTests.swift
//  Weather displayerTests
//
//  Created by Federico Imberti on 12/02/22.
//

import XCTest
import Combine
@testable import Weather_displayer

class DownloadDataManagerTests: XCTestCase {
	
	let downloadDataManager = DownloadDataManager.getShared()
	
	func test_DownloadDataManager_init_downloadedDataEqualToCazzanoData() throws{
		//Given
		let expectedCityName = "Cazzano Sant'Andrea"
		
		//When
		let downloadedData = try awaitPublisher(downloadDataManager.$downloadedData.collect(2).first())
		
		//Then
		XCTAssertEqual(expectedCityName, downloadedData[1].cityname)
	}
		
}

extension XCTestCase {
	func awaitPublisher<T: Publisher>(
		_ publisher: T,
		timeout: TimeInterval = 10,
		file: StaticString = #file,
		line: UInt = #line
	) throws -> T.Output {
		// We use Swift's Result type to keep track
		// of the result of our Combine pipeline:
		var result: Result<T.Output, Error>?
		let expectation = self.expectation(description: "Awaiting publisher")

		let cancellable = publisher.sink(
			receiveCompletion: { completion in
				switch completion {
				case .failure(let error):
					result = .failure(error)
				case .finished:
					break
				}

				expectation.fulfill()
			},
			receiveValue: { value in
				result = .success(value)
			}
		)

		// We await the expectation that we
		// created at the top of our test, and once done, we
		// also cancel our cancellable to avoid getting any
		// unused variable warnings:
		waitForExpectations(timeout: timeout)
		cancellable.cancel()

		// Here we pass the original file and line number that
		// our utility was called at, to tell XCTest to report
		// any encountered errors at that original call site:
		let unwrappedResult = try XCTUnwrap(
			result,
			"Awaited publisher did not produce any output",
			file: file,
			line: line
		)

		return try unwrappedResult.get()
	}
}
