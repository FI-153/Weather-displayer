//
//  WeatherDetailsView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 11/02/22.
//

import SwiftUI

struct WeatherDetailsView: View {
	
	@StateObject var vm:WeatherDetailsViewModel
	
	var body: some View {
		VStack{
			HStack(spacing: 20){
				weatherImage
				
				titleAndSubtitle
				
				dismissButton
				
			}
			.padding()
			.ignoresSafeArea()
			
			dayDetails
		}
	}
}

extension WeatherDetailsView {
	private var dismissButton: some View {
		Button {
			vm.isSheetShown.toggle()
		} label: {
			Image(systemName: "xmark")
				.font(.system(size: 20, weight: .semibold))
				.foregroundColor(.primary)
				.frame(width: 50, height: 50)
				.background(Color.secondary.opacity(0.3))
				.clipShape(Circle())
				.shadow(radius: 15)
		}
	}
	
	private var weatherImage: some View{
		Image(systemName: vm.day.icon!)
			.resizable()
			.symbolRenderingMode(.multicolor)
			.scaledToFit()
			.frame(width: 110, height: 110)
			.shadow(radius: 15)

	}
	
	private var titleAndSubtitle: some View{
		VStack(alignment: .leading){
			
			Text(vm.day.conditions![0]!)
				.bold()
				.font(.title)
			
			//Display subtitle only if present
			if vm.isSubtitlePresent() {
				Text(vm.day.conditions![1]!)
					.font(.title3)
			}
			
		}
	}
	
	private var dayDetails: some View{
		Group{
			HStack {
				WeatherDetailsViewElement(title: "Max Temp", bigValue: "\(vm.day.tempMax!)°C")
				WeatherDetailsViewElement(title: "Min Temp", bigValue: "\(vm.day.tempMin!)°C")
			}
			HStack {
				WeatherDetailsViewElement(title: "Precipitation", image: "cloud.drizzle.fill", displayedInfo: "\(vm.day.precip!)mm")
				WeatherDetailsViewElement(title: "Wind Speed", image: "wind", displayedInfo: "\(vm.day.windSpeed!)")
			}
			HStack{
				WeatherDetailsViewElement(title: "UV Index", image: "sun.max.fill", displayedInfo: String(vm.day.uvIndex!))
				WeatherDetailsViewElement(title: "Solar Energy", image: "bolt.fill", displayedInfo: "\(vm.day.solarEnergy!)MWh")
			}
		}
		
	}
}


struct WeatherDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			BackgroundView()
			WeatherDetailsView(vm: WeatherDetailsViewModel(isSheetShown: .constant(true), day: Day.mockData[0]))
		}
    }
}
