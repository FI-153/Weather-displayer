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
	
	///Singleton instance of the class
	static let shared = DownloadDataManager()
	private init(){
		do{
			try downloadWeatherData()
		}catch let error {
			print(error)
		}
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	func downloadWeatherData() throws{
		guard let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Cazzano%20sant'Andrea/next7days?unitGroup=metric&include=days&key=AZSUM3BTUUFQD2FRU4T8ZR6MQ&contentType=json") else {
			throw URLError(.badURL)
		}
		
		URLSession.shared.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: WeatherData.self, decoder: JSONDecoder())
			.replaceError(with: WeatherData.mockData)
			.sink { [weak self] receivedWeather in
				guard let self = self else { return }
				
				self.downloadedData = receivedWeather
				
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
	
}
