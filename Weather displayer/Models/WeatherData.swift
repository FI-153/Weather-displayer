//
//  WeatherData.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit

struct Day: Identifiable, Decodable {
    
    let id = UUID()
    var datetime:String?
    var temp:Float?
    var precip:Float?
    var description:String?
    
    private init(datetime: String, temp: Float, precip: Float, description: String) {
        self.datetime = datetime
        self.temp = temp
        self.precip = precip
        self.description = description
    }
    
    private enum CodingKeys: String, CodingKey {
        case datetime, temp, precip, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.datetime = try container.decode(String.self, forKey: CodingKeys.datetime)
            self.temp = try container.decode(Float.self, forKey: CodingKeys.temp)
            self.precip = try container.decode(Float.self, forKey: CodingKeys.precip)
            self.description = try container.decode(String.self, forKey: CodingKeys.description)
        }catch let error {
            print(error)
        }
    }
    
    ///Mock data to be used during development
    static let mockData = [
        Day(datetime: "date", temp: 8.1, precip: 0, description: "Desctiption of weather data"),
        Day(datetime: "date2", temp: 9.5, precip: 1, description: "Desctiption of weather data2")
    ]
}

struct WeatherData: Identifiable, Decodable {
    
    let id = UUID()
    var resolvedAddress:String?
    var days:[Day]?
    
    private enum CodingKeys: String, CodingKey {
        case resolvedAddress, days
    }
    
    private init(resolvedAddress:String, days:[Day]){
        self.resolvedAddress = resolvedAddress
        self.days = days
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.resolvedAddress = try container.decode(String.self, forKey: CodingKeys.resolvedAddress)
            self.days = try container.decode([Day].self, forKey: CodingKeys.days)
        }catch let error {
            print(error)
        }
    }
    
    ///Mock data to be used during development
    static let mockData = WeatherData(resolvedAddress: "Address1", days: Day.mockData)
}
