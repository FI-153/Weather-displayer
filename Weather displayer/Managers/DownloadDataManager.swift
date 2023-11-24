//
//  DownloadDataManager.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit
import Combine

class DownloadDataManager {
	
	///Publishes all downloaded locations. Initilised to mock data.
	@Published var downloadedData:WeatherData
	
	///Stores the previous downloaded weather data
	private var previouslyDownloadedData:WeatherData?
	
	///Describes if a download is in progress
	@Published var isLoading:Bool
    
    private var cancellables:Set<AnyCancellable>
	
	///Singleton instance of the class
	private static let shared = DownloadDataManager()
	private init(){
        self.isLoading =      true
        self.downloadedData = WeatherData.mockData
        self.cancellables =   Set<AnyCancellable>()
        
		Task(priority: .high){
			do{
				try await downloadWeatherData(for: "Dalmine")
			}catch let error {
				isLoading = false
				print(error)
			}
		}
	}
	///Refer to this to get the singleton instance to keep track of the call hierarchy
	static func getShared() -> DownloadDataManager {
		return shared
	}
	
	
	///Downloads weather data for a specifiec location
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
			response.statusCode >= 200 && response.statusCode < 300 
        else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
	}
	
	///Creates the URL version of the given string
	private func createUrl(for location: String) throws -> URL{
		
		guard let url = URL(string: composeUrlRequest(for: location)) else {
			throw URLError(.badURL)
		}

		return url
	}
	
	///Composes an URL request to conform to the API format
	private func composeUrlRequest(for location: String) -> String {
		
        let base = "https://zenweatherproxy.onrender.com/getWeather?location="
        let formattedLocation = location
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: .illegalCharacters)
            .filter{ !" \n\t\r".contains($0) }
		
        return base.appending(formattedLocation)
	}
	
	///Downloads the data at the given URL through a URLSession then saves it
	private func downloadData(for url: URL) {
		
		URLSession.shared
            .dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: WeatherData.self, decoder: JSONDecoder())
			.replaceError(with: previouslyDownloadedData ?? WeatherData.mockData)
			.sink { [weak self] receivedWeather in
				
				guard let self = self else { return }
                
                self.previouslyDownloadedData = downloadedData
                self.downloadedData = receivedWeather
				self.isLoading = false
			}
			.store(in: &cancellables)
	}
}
