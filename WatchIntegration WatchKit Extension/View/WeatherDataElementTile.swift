//
//  WeatherDataElement.swift
//  WatchIntegration WatchKit Extension
//
//  Created by Federico Imberti on 15/02/22.
//

import SwiftUI

struct WeatherDataElementTile: View {
	
	var title:String?
	var image:String?
	var displayedInfo:String?
	var bigValue:String?
	
	var body: some View {
		ZStack {
			background
			
			VStack{
				
				if
					let image = image,
					let displayedInfo = displayedInfo
				{
					showFirstConfiguration(image, displayedInfo)
					
				} else if
					let title = title,
					let bigValue = bigValue
				{
					showSecondConfiguration(title, bigValue)
					
				}
				
			}
		}
		
	}
}

extension WeatherDataElementTile {
	private var background: some View {
		RoundedRectangle(cornerRadius: 10)
			.fill(Color.secondary.opacity(0.3))
			.frame(width: 70, height: 70)
	}
}

private func showFirstConfiguration(_ image:String, _ displayedInfo:String) -> some View{
	VStack{
		Image(systemName: image)
			.resizable()
			.scaledToFit()
			.symbolRenderingMode(.multicolor)
			.frame(height: 20)
		
		Text(displayedInfo)
			.fontWeight(.semibold)
			.padding(3)
	}
}

private func showSecondConfiguration(_ title:String, _ bigValue:String) -> some View {
	VStack{
		Text(title)
		
		Text(bigValue)
			.font(.title3)
			.fontWeight(.semibold)
			.padding(3)
	}
}

struct WeatherDataElement_Previews: PreviewProvider {
	static var previews: some View {
		ScrollView(.vertical) {
			VStack(spacing: 15){
				HStack(spacing: 15) {
					WeatherDataElementTile(title: "Max", bigValue: "10°C")
					WeatherDataElementTile(title: "Min", bigValue: "-1°C")
				}
				HStack(spacing: 15) {
					WeatherDataElementTile(title: "Precipitation", image: "cloud.drizzle.fill", displayedInfo: "12 mm")
					WeatherDataElementTile(title: "Wind Speed", image: "wind", displayedInfo: "12 Km/h")
				}
			}
		}
		
	}
}
