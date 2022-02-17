//
//  WeatherDataElementPill.swift
//  WatchIntegration WatchKit Extension
//
//  Created by Federico Imberti on 17/02/22.
//

import SwiftUI

struct WeatherDataElementPill: View {
	
	var title:String?
	var image:String?
	var displayedInfo:String?
	
    var body: some View {
		ZStack{
			background
			
			HStack{
				VStack{
					Text(title!)
						.font(.subheadline)
						.minimumScaleFactor(0.8)
					
					Spacer()
					
					Text(displayedInfo!)
						.font(.headline)
				}
				.padding()
				
				Spacer()
				
				Image(systemName: image!)
					.resizable()
					.scaledToFit()
					.symbolRenderingMode(.multicolor)
					.frame(width: 30, height: 30)
					.padding()
			}
			
		}
		.frame(height: 75)
		
    }
}

extension WeatherDataElementPill {
	private var background: some View {
		RoundedRectangle(cornerRadius: 10)
			.fill(Color.secondary.opacity(0.3))
	}
}


struct WeatherDataElementPill_Previews: PreviewProvider {
    static var previews: some View {
		ScrollView{
			WeatherDataElementPill(title: "Precipitation", image: "cloud.drizzle.fill", displayedInfo: "12 mm")
			WeatherDataElementPill(title: "Wind Speed", image: "wind", displayedInfo: "12 KM/H")
		}
    }
}
