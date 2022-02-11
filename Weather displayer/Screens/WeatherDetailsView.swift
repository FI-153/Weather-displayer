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
		NavigationView{
			VStack{
				HStack{
					weatherImage
					
					VStack(alignment: .leading){
						if
							let title = 		day.conditions?[0],
							let subtitle = 	day.conditions?[1]
						{
							Text(title)
								.bold()
								.font(.title)
							Text(subtitle)
								.font(.title3)
						}
					}
					
					Spacer()
				}
				.padding()
				.ignoresSafeArea()
				
				
				
				Spacer()
			}
			.toolbar {
				ToolbarItem(placement: .automatic) {
					dismissButton
				}
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
			WeatherDetailsView(isSheetShown: .constant(true), day: Day.mockData[2])
		}
    }
}
