//
//  WeatherData.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit

struct Day: Identifiable, Decodable, Equatable {
	
	let id = UUID()
	
	///Date of the forecast, format dd/mm
	var datetime:		String?
	
	///Avg temperature during the day
	var temp:			Float?
	
	///Chances of precipitations
	var precip:		Float?
	
	///Icon to be displayed (see WeatherDataIcons)
	var icon:			String?
	
	///Description of the day's weather
	var description:	String?
	
	private init(datetime: String, temp: Float, precip: Float, icon:	String, description: String) {
		self.datetime = 	extractDate(date: datetime)
		self.temp = 		temp
		self.precip = 	precip
		self.icon =		icon
		self.description =	description
	}
	
	private enum CodingKeys: String, CodingKey {
		case datetime, temp, precip, icon, description
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		do {
			//self.datetime = 	try container.decode(String.self, forKey: CodingKeys.datetime)
			self.datetime =	extractDate(date: try container.decode(String.self, forKey: CodingKeys.datetime))
			self.temp = 		try container.decode(Float.self, forKey: CodingKeys.temp)
			self.precip = 	try container.decode(Float.self, forKey: CodingKeys.precip)
			self.icon =		try container.decode(String.self, forKey: CodingKeys.icon)
			self.description = try container.decode(String.self, forKey: CodingKeys.description)
		}catch let error {
			print(error)
		}
	}
	
	func extractDate(date: String) -> String{
		let separatedDate = date.components(separatedBy: "-")
		
		return separatedDate[2] + "/" + separatedDate[1]
	}
	
	static func == (lhs: Day, rhs: Day) -> Bool {
		return lhs.id == rhs.id && lhs.id == rhs.id
	}
	
	///Mock data to be used during development
	static let mockData = [
		Day(datetime: "2021-02-01", temp: 8.1, precip: 0, icon: "cloudy", description: "Desctiption of weather data"),
		Day(datetime: "2021-02-01", temp: 9.5, precip: 90, icon: "rain", description: "Desctiption of weather data2"),
		Day(datetime: "2021-02-01", temp: 10, precip: 0, icon: "partly-cloudy-day", description: "Desctiption of weather data2"),
		Day(datetime: "2021-02-01", temp: 21, precip: 0, icon: "cloudy", description: "Desctiption of weather data2"),
		Day(datetime: "2021-02-01", temp: -2, precip: 45, icon: "rain", description: "Desctiption of weather data2"),
		Day(datetime: "2021-02-01", temp: 4.1, precip: 0, icon: "partly-cloudy-day", description: "Desctiption of weather data2"),
		Day(datetime: "2021-02-01", temp: 4.1, precip: 0, icon: "partly-cloudy-day", description: "Desctiption of weather data2")
	]
}

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
	
	private init(resolvedAddress:String, days:[Day]){
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
	static let mockData = WeatherData(resolvedAddress: "Address1, b, c", days: Day.mockData)
}
