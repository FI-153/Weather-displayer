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
	
	///Will be false is the downaloader has finished downloading data
	@Published var isLoading:Bool = true
	
	///Singleton instance of the class (refer to it via its getter)
	static let shared = DownloadDataManager()
	public init(isForTesting:Bool = false){
		
		if !isForTesting {
			Task.init{
				do{
					try await downloadWeatherData(for: "Cazzano sant'Andrea")
				}catch let error {
					isLoading = false
					print(error)
				}
			}
		}
		
	}
	///Refer to this to get the singleton instance to keep track of the call hierarchy
	static func getShared() -> DownloadDataManager {
		return shared
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	///Weather data is downloaded for a specifiec location
	func downloadWeatherData(for location:String) async throws{
		
		do {
			isLoading = true
			
			let url = try createUrl(for: location)

			downloadData(for: url)

		} catch let error{
			throw error
		}
		
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
	
	///Creates the URL version of the given string
	public func createUrl(for location: String) throws -> URL{
		
		guard let url = URL(string: composeUrlRequest(for: location)) else {
			throw URLError(.badURL)
		}

		return url
	}
	
	///Composes an URL request to conform to the API format
	public func composeUrlRequest(for location: String) -> String {
		
		let before 				= "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/"
		let after 				= "/next7days?unitGroup=metric&include=days&key=AZSUM3BTUUFQD2FRU4T8ZR6MQ&contentType=json"
		let formattedLocation 	= location.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .illegalCharacters).filter{ !" \n\t\r".contains($0) }
		
		return before + formattedLocation + after
	}
	
	///Downloads the data at the given URL then saves it
	public func downloadData(for url: URL) {
		
		URLSession.shared.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: WeatherData.self, decoder: JSONDecoder())
			.replaceError(with: previouslyDownloadedData ?? WeatherData.mockData)
			.sink { [weak self] receivedWeather in
				
				guard let self = self else { return }
				
				self.saveData(to: receivedWeather)
				self.isLoading = false
			}
			.store(in: &cancellables)
		
	}
	
	private func saveData(to data: WeatherData){
		setDownloadedData(to: data)
		setPreviouslyDownloadedData(to: data)
	}
	
	private func setPreviouslyDownloadedData(to data: WeatherData) {
		self.previouslyDownloadedData = data
	}
	
	private func setDownloadedData(to data: WeatherData) {
		self.downloadedData = data
	}
	
}
