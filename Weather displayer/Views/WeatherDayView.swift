//
//  WeatherDayView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 02/02/22.
//

import Foundation
import SwiftUI

struct WeatherDayView: View {
	var dayOfWeek:			String
	var imageName:			String
	var temperature:		Float
	var precipitaionChance:	Float
	
	var body: some View {
		VStack{
			Text(self.dayOfWeek)
				.font(.callout)
				.fontWeight(.semibold)
				.foregroundColor(.white)
			
			Image(systemName: self.imageName)
				.symbolRenderingMode(.multicolor)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 40, height: 40)
			
			Text(String(self.temperature) + "°C")
				.font(.title3)
				.foregroundColor(.white)
			
			VStack{
				if precipitaionChance > 0 {
					Text(String(Int(self.precipitaionChance)) + "%")
						.font(.headline)
						.foregroundColor(.secondary)
				}
			}
			.frame(maxHeight: 20)
		}
	}
}

struct WeatherDayView_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			BackgroundView()
			
			ScrollView(.horizontal) {
				HStack {
					WeatherDayView(
						dayOfWeek: Day.mockData.first!.datetime!,
						imageName: WeatherDataIcons.icons[Day.mockData.first!.icon!] ?? "",
						temperature: Day.mockData.first!.temp!,
						precipitaionChance: Day.mockData.first!.precip!
					)
						.padding()
					
					WeatherDayView(
						dayOfWeek: Day.mockData.last!.datetime!,
						imageName: WeatherDataIcons.icons[Day.mockData.last!.icon!] ?? "",
						temperature: Day.mockData.last!.temp!,
						precipitaionChance: Day.mockData.last!.precip!
					)
						.padding()
				}
			}
			.padding()
		}
	}
}
