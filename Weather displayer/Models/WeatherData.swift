//
//  WeatherData.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit

struct WeatherData: Identifiable, Decodable, Equatable {
	
	let id = UUID()
	
	///Resolved address by the server, format cityname, province, country
	var resolvedAddress:	String?
	
	var cityname:			String?
	var provinceAndCountry: String?
	
	///Array of the weather of all downloaded days
	var days:				[Day]?
	
	private enum CodingKeys: String, CodingKey {
		case resolvedAddress, days
	}
	
	init(resolvedAddress:String, days:[Day]){
		self.resolvedAddress = 		resolvedAddress
		self.cityname =			extractCityName(from: resolvedAddress)
		self.provinceAndCountry = 	extractProvinceAndCountry(from: resolvedAddress)
		self.days = 				days
	}
	
	init(from decoder: Decoder) throws {
		do {
			let container = 			try decoder.container(keyedBy: CodingKeys.self)
			self.resolvedAddress = 		try container.decode(String.self, forKey: CodingKeys.resolvedAddress)
			self.cityname =			extractCityName(from: resolvedAddress!)
			self.provinceAndCountry = 	extractProvinceAndCountry(from: resolvedAddress!)
			self.days = 				try container.decode([Day].self, forKey: CodingKeys.days)
		}catch let error {
			print(error)
		}
	}
	
	func extractProvinceAndCountry(from address: String) -> String {
		let separatedAddress = address.components(separatedBy: ", ")
		
		if !separatedAddress.isEmpty {
			return separatedAddress[1] + ", " + separatedAddress[2]
		}
		
		return ""
	}
	
	func extractCityName(from address: String) -> String {
		let separatedAddress = address.components(separatedBy: ", ")
		
		if !separatedAddress.isEmpty {
			return separatedAddress[0]
		}
		
		return ""
	}
	
	///Mock data to be used during development
	static let mockData = WeatherData(resolvedAddress: "MockCityName, MockRegion, MockCountry", days: Day.mockData)
}
