//
//  Day.swift
//  Weather displayer
//
//  Created by Federico Imberti on 11/02/22.
//

import Foundation
import UIKit

struct Day: Identifiable, Decodable, Equatable {
	
	let id = UUID()
	
	///Date of the forecast, format dd/mm
	var datetime:		String?
	
	///Avg temperature during the day
	var temp:			Float?
	
	///Chances of precipitations
	var precipProb:	Float?
	
	///Icon to be displayed (see WeatherDataIcons)
	var icon:			String?
	
	///Description of the day's weather
	var description:	String?
	
	///Mamimum temperature
	var tempMax:		Float?
	
	///Minimum temperatiure
	var tempMin:		Float?
	
	///Short desctiption of the conditions, [0] is always present while [1] can sometimes not be present
	var conditions:	[String?]?
	
	///Wind speed in Km/h
	var windSpeed:		Float?
	
	///Amount of precipitation in mm
	var precip:		Float?
	
	///Solar energy in MWh
	var solarEnergy:	Float?
	
	private init(datetime: String, temp: Float, precipProb: Float, icon: String, description: String, tempMax: Float, tempMin: Float, conditions: String, windSpeed: Float, precip: Float, solarEnergy:Float) {
		self.datetime = 	extractDate(date: datetime)
		self.temp = 		temp
		self.precipProb = 	precipProb
		self.icon =		WeatherIcons.icons[icon]
		self.description =	description
		self.tempMax = tempMax
		self.tempMin = tempMin
		self.conditions = extractConditions(from: conditions)
		self.windSpeed = windSpeed
		self.precip = precip
		self.solarEnergy = solarEnergy
	}
	
	private enum CodingKeys: String, CodingKey {
		case datetime, temp, precipprob, icon, description, tempmax, tempmin, conditions, windspeed, precip, solarenergy
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		do {
			self.datetime =	extractDate(date: try container.decode(String.self, forKey: CodingKeys.datetime))
			self.temp = 		try container.decode(Float.self, forKey: CodingKeys.temp)
			self.precipProb = 	try container.decode(Float.self, forKey: CodingKeys.precipprob)
			self.icon =		WeatherIcons.icons[try container.decode(String.self, forKey: CodingKeys.icon)]
			self.description = try container.decode(String.self, forKey: CodingKeys.description)
			self.tempMax =		try container.decode(Float.self, forKey: CodingKeys.tempmax)
			self.tempMin = 	try container.decode(Float.self, forKey: CodingKeys.tempmin)
			self.conditions =	extractConditions(from: try container.decode(String.self, forKey: CodingKeys.conditions))
			self.windSpeed = 	try container.decode(Float.self, forKey: CodingKeys.windspeed)
			self.precip = 	try container.decode(Float.self, forKey: CodingKeys.precip)
			self.solarEnergy = try container.decode(Float.self, forKey: CodingKeys.solarenergy)
		}catch let error {
			print(error)
		}
	}
	
	func extractDate(date: String) -> String{
		let separatedDate = date.components(separatedBy: "-")
		
		return separatedDate[2] + "/" + separatedDate[1]
	}
	
	func extractConditions(from string:String) -> [String] {
		let separatedConditions = string.components(separatedBy: ", ")
		return separatedConditions
	}
	
	static func == (lhs: Day, rhs: Day) -> Bool {
		return lhs.id == rhs.id && lhs.id == rhs.id
	}
	
	///Mock data to be used during development
	static let mockData = [
		Day(datetime: "2021-02-01", temp: 8.1, precipProb: 0, icon: "cloudy", description: "Desctiption of weather data", tempMax: 10, tempMin: -1, conditions: "Cloudy, partially cloudy", windSpeed: 12, precip: 0, solarEnergy: 7.5),
		Day(datetime: "2021-02-01", temp: 9.5, precipProb: 90, icon: "rain", description: "Desctiption of weather data2", tempMax: 10, tempMin: -1, conditions: "Rain", windSpeed: 12, precip: 0, solarEnergy: 7.5),
		Day(datetime: "2021-02-01", temp: 10, precipProb: 0, icon: "partly-cloudy-day", description: "Desctiption of weather data2", tempMax: 10, tempMin: -1, conditions: "Partially cloudy", windSpeed: 12, precip: 0, solarEnergy: 7.5),
		Day(datetime: "2021-02-01", temp: 21, precipProb: 0, icon: "cloudy", description: "Desctiption of weather data2", tempMax: 10, tempMin: -1, conditions: "Snow, Partially cloudy", windSpeed: 12, precip: 0, solarEnergy: 7.5),
		Day(datetime: "2021-02-01", temp: -2, precipProb: 45, icon: "rain", description: "Desctiption of weather data2", tempMax: 10, tempMin: -1, conditions: "Snow, Overcast", windSpeed: 12, precip: 0, solarEnergy: 7.5),
		Day(datetime: "2021-02-01", temp: 4.1, precipProb: 0, icon: "partly-cloudy-day", description: "Desctiption of weather data2", tempMax: 10, tempMin: -1, conditions: "Partially cloudy", windSpeed: 12, precip: 0, solarEnergy: 7.5),
		Day(datetime: "2021-02-01", temp: 4.1, precipProb: 0, icon: "partly-cloudy-day", description: "Desctiption of weather data2", tempMax: 10, tempMin: -1, conditions: "Overcast", windSpeed: 12, precip: 0, solarEnergy: 7.5)
	]
}
