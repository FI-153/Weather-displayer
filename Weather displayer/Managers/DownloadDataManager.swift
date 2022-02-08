//
//  DownloadDataManager.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit
import Combine

class DownloadDataManager {
	
	///Publishes all downloaded locations
	@Published var downloadedData:WeatherData = WeatherData.mockData
	
	///Saves the previous downloaded weather data
	private var previouslyDownloadedData:WeatherData?
	
	///Checks if the downloader is downloading Data
	@Published var isLoading:Bool = true
	
	///Singleton instance of the class
	static let shared = DownloadDataManager()
	private init(){
		do{
			try downloadWeatherData(for: "Cazzano sant'Andrea")
		}catch let error {
			print(error)
		}
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	///Downloads the weahter data, docodes it and publishes it to downloadedData
	public func downloadWeatherData(for location:String) throws{
		guard let url = URL(string: createUrlRequest(for: location)) else {
			throw URLError(.badURL)
		}
		
		print(createUrlRequest(for: location))
		
		URLSession.shared.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: WeatherData.self, decoder: JSONDecoder())
			.replaceError(with: previouslyDownloadedData ?? WeatherData.mockData)
			.sink { [weak self] receivedWeather in
				guard let self = self else { return }
				
				self.downloadedData = 			receivedWeather
				self.previouslyDownloadedData = 	receivedWeather
				self.isLoading = 	false
			}
			.store(in: &cancellables)
		
	}
	
	///Handles the output from the downloader
	private func handleOutput(output:URLSession.DataTaskPublisher.Output) throws -> Data {
		guard
			let response = output.response as? HTTPURLResponse,
			response.statusCode >= 200 && response.statusCode < 300 else {
				throw URLError(.badServerResponse)
			}
		return output.data
	}
	
	///Compiles the URL request do download the weather data from a location
	private func createUrlRequest(for location: String) -> String {
		
		let before 				= "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/"
		let after 				= "/next7days?unitGroup=metric&include=days&key=AZSUM3BTUUFQD2FRU4T8ZR6MQ&contentType=json"
		let formattedLocation 	= location.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .illegalCharacters).filter{ !" \n\t\r".contains($0) }
		
		return before + formattedLocation + after
	}
	
}
