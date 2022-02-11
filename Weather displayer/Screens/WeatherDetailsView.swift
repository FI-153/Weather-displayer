//
//  WeatherDetailsView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 11/02/22.
//

import SwiftUI

struct WeatherDetailsView: View {
	@Binding var isSheetShown:Bool
	var day:Day
	
	var body: some View {
			VStack{
				HStack(spacing: 20){
					weatherImage
					
					VStack(alignment: .leading){
						
						Text(day.conditions![0]!)
							.bold()
							.font(.title)
						
						//Display subtitle only if present
						if day.conditions!.count == 2 {
							Text(day.conditions![1]!)
								.font(.title3)
						}
						
					}
					
					dismissButton
					
				}
				.padding()
				.ignoresSafeArea()

				HStack {
					WeatherDetailsViewElement(title: "Max Temp", bigValue: "\(day.tempMax!)°C")
					WeatherDetailsViewElement(title: "Min Temp", bigValue: "\(day.tempMin!)°C")
				}
				HStack {
					WeatherDetailsViewElement(title: "Precipitation", image: "cloud.drizzle.fill", displayedInfo: "\(day.precip!)mm")
					WeatherDetailsViewElement(title: "Wind Speed", image: "wind", displayedInfo: "\(day.windSpeed!)")
				}
				HStack{
					WeatherDetailsViewElement(title: "UV Index", image: "sun.max.fill", displayedInfo: "5")
					WeatherDetailsViewElement(title: "Solar Energy", image: "bolt.fill", displayedInfo: "\(day.solarEnergy!)MWh")
				}
				
			}
			
		
	}
}

extension WeatherDetailsView {
	private var dismissButton: some View {
		Button {
			isSheetShown.toggle()
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
		Image(systemName: day.icon!)
			.resizable()
			.symbolRenderingMode(.multicolor)
			.scaledToFit()
			.frame(width: 110, height: 110)
			.shadow(radius: 15)

	}
}


struct WeatherDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			BackgroundView()
			WeatherDetailsView(isSheetShown: .constant(true), day: Day.mockData[0])
		}
    }
}
