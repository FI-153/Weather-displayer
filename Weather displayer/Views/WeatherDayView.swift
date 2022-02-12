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
	
	var isSelected:Bool? = false
	
	var body: some View {
		ZStack {
				
			Color.secondary.opacity(isSelected! ? 0.4 : 0.2)
			
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
				.frame(height: 20)
			}
		}
		.frame(width: 80, height: 150)
		.clipShape(RoundedRectangle(cornerRadius: 15))
	}
}

struct WeatherDayView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			ZStack {
				BackgroundView()
				
				ScrollView(.horizontal, showsIndicators: false){
					HStack{
						ForEach(Day.mockData){ day in
							
							if
								let dayOfTheWeek =	day.datetime,
								let imageName = 		day.icon,
								let temperature = 	day.temp,
								let precipitation = 	day.precipProb
							{
								WeatherDayView(
									dayOfWeek: 		dayOfTheWeek,
									imageName: 		imageName,
									temperature: 		temperature,
									precipitaionChance:	precipitation,
									isSelected: 		false
								)
							}
							
						}
					}
				}
				.padding(.horizontal)
			}
			
			ZStack {
				BackgroundView()
				
				ScrollView(.horizontal, showsIndicators: false){
					HStack{
						ForEach(Day.mockData){ day in
							
							if
								let dayOfTheWeek =	day.datetime,
								let conditions = 	day.icon,
								let temperature = 	day.temp,
								let precipitation = 	day.precipProb
							{
								WeatherDayView(
									dayOfWeek: dayOfTheWeek,
									imageName: WeatherIcons.icons[conditions] ?? "",
									temperature: temperature,
									precipitaionChance: precipitation,
									isSelected: false
								)
							}
							
						}
					}
				}
				.padding(.horizontal)
			}
			.preferredColorScheme(.dark)
		}
	}
}
