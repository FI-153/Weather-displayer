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
	var resolvedAddress: String?
	
	var cityname: String?
	var provinceAndCountry: String?
	
	///Array of the weather of all downloaded days
	var days: [Day]?
	
	private enum CodingKeys: String, CodingKey {
		case resolvedAddress, days
	}
	
	init(resolvedAddress:String, days:[Day]){
		self.resolvedAddress =      resolvedAddress
        let parsedAddress = extractCityProvinceAndCountry(from: resolvedAddress)
        self.cityname =             parsedAddress.city
        self.provinceAndCountry =   parsedAddress.province + parsedAddress.country
		self.days =                 days
	}
	
	init(from decoder: Decoder) throws {
		do {
			let container = 			try decoder.container(keyedBy: CodingKeys.self)
			self.resolvedAddress = 		try container.decode(String.self, forKey: CodingKeys.resolvedAddress)
            let parsedAddress =         extractCityProvinceAndCountry(from: resolvedAddress!)
            self.cityname =             parsedAddress.city
            self.provinceAndCountry =   parsedAddress.province + parsedAddress.country
			self.days = 				try container.decode([Day].self, forKey: CodingKeys.days)
		}catch let error {
			print(error)
		}
	}
	    
    /**
     Returns the city, province and country from the given address as a tuple
     - Parameter address: address to parse
     - Returns: city, province and country of the given string. Country is preceded by a space and comma
     */
    func extractCityProvinceAndCountry(from address: String) -> (city: String, province: String, country: String) {
        let separatedAddress = address.components(separatedBy: ", ")
        
        switch separatedAddress.count {
        case 3:
            return (separatedAddress[0], separatedAddress[1], ", " + separatedAddress[2])
        case 2:
            return (separatedAddress[0], separatedAddress[1], "")
        case 1:
            return (separatedAddress[0], "", "")
        default:
            return ("", "", "")
        }
    }
	
	///Mock data to be used during development
	static let mockData = WeatherData(resolvedAddress: "MockCityName, MockRegion, MockCountry", days: Day.mockData)
}
