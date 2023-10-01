//
//  WeatherDataElementPill.swift
//  WatchIntegration WatchKit Extension
//
//  Created by Federico Imberti on 17/02/22.
//

import SwiftUI

struct WeatherDataElementPill: View {
	
	var title:String
	var image:String
	var displayedInfo:String
	
    var body: some View {
		ZStack{
			background
			
            HStack{
				titleAndDisplayedInfo
                Spacer()
				imageSection
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
	
	private var titleAndDisplayedInfo: some View{
        VStack(alignment: .leading, spacing: 5){
			Text(title)
				.font(.subheadline)
                .foregroundStyle(.secondary)
						
			Text(displayedInfo)
				.font(.headline)
		}
        .padding(.leading)
	}
	
	private var imageSection: some View{
		Image(systemName: image)
			.resizable()
			.scaledToFit()
			.symbolRenderingMode(.multicolor)
			.frame(width: 30, height: 30)
            .padding(.trailing)
	}
}


struct WeatherDataElementPill_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            VStack{
                WeatherDataElementPill(title: "Precipitations", image: "cloud.drizzle.fill", displayedInfo: "12 mm")
                WeatherDataElementPill(title: "Wind Speed", image: "wind", displayedInfo: "12 Km/h")
            }
        }
    }
}
