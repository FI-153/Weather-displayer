//
//  Weather_displayerTests.swift
//  Weather displayerTests
//
//  Created by Federico Imberti on 12/02/22.
//

import XCTest
@testable import Weather_displayer

class WeatherDataTests: XCTestCase {
	
	let city = 		"Cazzano Sant'Andrea"
	let province = 	"Lombardia"
	let country = 	"Italia"
	let weatherData:WeatherData = WeatherData(resolvedAddress: "Cazzano Sant'Andrea, Lombardia, Italia", days: [Day]())

	func test_WeatherData_extractProvinceAndCountry_ProcinceAndCountryAreExtracted(){
		//Given
		//When
		
		//Then
		XCTAssertEqual(province + ", " + country, weatherData.provinceAndCountry)
	}
	
	func test_WeatherData_extractCity_theCityisExtracted(){
		//Given
		//When
		
		//Then
		XCTAssertEqual(city, weatherData.cityname)
	}

}
