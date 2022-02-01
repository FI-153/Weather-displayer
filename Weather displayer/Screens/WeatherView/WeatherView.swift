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
				cityTextView(cityname: "Cupertino, CA")
				
				//Current weather
				mainWeatherIcon(imageName: "cloud.sun.fill", temperature: 76, description: "Cloudy with a Chance of Meatballs")
				
				//Weather day by day
				HStack(spacing: 20){
					WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74, precipitaionChance: 0)
					WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 80, precipitaionChance: 0)
					WeatherDayView(dayOfWeek: "THU", imageName: "wind.snow", temperature: 76, precipitaionChance: 30)
					WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.bolt.fill", temperature: 76, precipitaionChance: 40)
					WeatherDayView(dayOfWeek: "SAT", imageName: "snow", temperature: 76, precipitaionChance: 0)
					WeatherDayView(dayOfWeek: "SUN", imageName: "sunset.fill", temperature: 76, precipitaionChance: 60)
				}
				
				Spacer()
				
				Button {
					print(vm.weatherDataArray)
					print("<<< \(vm.weatherDataArray.days!.count)")
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
	var temperature:		Int;
	var precipitaionChance:	Int;
	
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
			
			Text(String(self.temperature) + "°")
				.font(.title)
				.foregroundColor(.white)
			
			VStack{
				if precipitaionChance > 0 {
					Text(String(self.precipitaionChance) + "%")
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
	var temperature:	Int
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
		}
		.padding(.bottom, 40)
	}
}
