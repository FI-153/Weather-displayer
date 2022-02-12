//
//  WeatherDetailsViewElement.swift
//  Weather displayer
//
//  Created by Federico Imberti on 11/02/22.
//

import SwiftUI

struct WeatherDetailsViewElement: View {
	var title:String
	var image:String?
	var displayedInfo:String?
	var bigValue:String?
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 15)
				.fill(Color.secondary.opacity(0.3))
			
			VStack{
				Text(title)
					.font(.title3)
					.fontWeight(.semibold)
				
				if
					let image = image,
					let displayedInfo = displayedInfo
				{
					Image(systemName: image)
						.resizable()
						.scaledToFit()
						.symbolRenderingMode(.multicolor)
						.frame(width: 50, height: 50)

					Text(displayedInfo)
						.font(.headline)
					
				} else if
					let bigValue = bigValue
				{
					
					Text(bigValue)
						.font(.largeTitle)
						.bold()
						.minimumScaleFactor(0.7)
						.padding()
					
				}
			}
			
		}
		.frame(width: 150, height: 150)
		
	}
}

struct WeatherDetailsViewElement_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			HStack {
				WeatherDetailsViewElement(title: "Max", bigValue: "21°C")
				WeatherDetailsViewElement(title: "Min", bigValue: "-1°C")
			}
			
			HStack {
				WeatherDetailsViewElement(title: "Precipitation", image: "cloud.drizzle.fill", displayedInfo: "12 mm")
				WeatherDetailsViewElement(title: "Wind Speed", image: "wind", displayedInfo: "34 KM/h")
			}
			
		}
	}
}
