//
//  ContentView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import SwiftUI

struct WeatherView: View {
	@State private var vm = WeatherViewModel()
	
	var body: some View {
		ZStack {
			backgroundView()
			
			VStack{
				
				Spacer()
				
				//title
				cityTextView(cityname: vm.locationDetails)
				
				//Current weather
				if
					let conditions = vm.todayWeather.conditions,
					let temparature = vm.todayWeather.temp,
					let description = vm.todayWeather.description
				{
					mainWeatherIcon(
						imageName: WeatherDataIcons.icons[conditions] ?? "",
						temperature: temparature,
						description: description
					)
				}
				
				//Weather next days
				ScrollView(.horizontal, showsIndicators: false){
					HStack(spacing: 20){
						ForEach(vm.nextDays){ day in
							
							if
								let conditions = day.conditions,
								let temperature = day.temp,
								let precipitation = day.precip
							{
								WeatherDayView(
									dayOfWeek: "01/01",
									imageName: WeatherDataIcons.icons[conditions] ?? "",
									temperature: temperature,
									precipitaionChance: precipitation
								)
							}
							
						}
					}
				}
				.padding(.horizontal)
				
				Spacer()
				
				Button {
					print(vm.nextDays)
				} label: {
					WeatherButtonView(title: "Change city")
						.shadow(radius: 5)
				}
				
				Spacer()
				
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			WeatherView()
			
			WeatherView()
				.preferredColorScheme(.dark)
		}
	}
}

struct WeatherDayView: View {
	var dayOfWeek:			String;
	var imageName:			String;
	var temperature:		Float;
	var precipitaionChance:	Float;
	
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

struct backgroundView: View {
	
	var body: some View {
		LinearGradient(	colors: [.pink.opacity(0.5), .blue.opacity(0.6)],
						startPoint: .topLeading,
						endPoint: .bottomTrailing)
			.ignoresSafeArea()
	}
}

struct cityTextView: View {
	var cityname:String
	
	var body: some View {
		Text(self.cityname)
			.font(.largeTitle)
			.fontWeight(.bold)
			.foregroundColor(.white)
			.padding()
	}
}

struct mainWeatherIcon: View {
	var imageName:		String
	var temperature:	Float
	var description:	String
	
	var body: some View {
		VStack(spacing: 8){
			Image(systemName: self.imageName)
				.renderingMode(.original)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 150, height: 150)
				.shadow(radius: 10)
			
			Text(String(self.temperature) + "°C")
				.font(.largeTitle)
				.fontWeight(.bold)
				.foregroundColor(.white)
			
			Text("\"" + description + "\"")
				.font(.title2)
				.fontWeight(.semibold)
				.foregroundColor(.secondary)
				.padding()
		}
		.padding(.bottom, 40)
	}
}
