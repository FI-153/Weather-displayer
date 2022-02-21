//
//  CityTextView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 02/02/22.
//

import Foundation
import SwiftUI

struct CityTextView: View {
	
	@Binding var titleText:String
	@Binding var isCityTextViewSelected:Bool
	var provinceAndCountry:String

	private let downloadDataManager = DownloadDataManager.getShared()

	var body: some View {
		VStack(alignment: .leading) {
			Group{
				TextField("", text: $titleText)
					.textFieldStyle(.plain)
					.keyboardType(.asciiCapable)
					.font(.system(size: 35, weight: .bold))
					.submitLabel(.go)
					.onSubmit {
						do {
							try downloadDataManager.downloadWeatherData(for: titleText)
						} catch {
							
						}
						isCityTextViewSelected = false
					}
					.onTapGesture {
						isCityTextViewSelected = true
					}
				
				Text(self.provinceAndCountry)
					.font(.title2)
					.fontWeight(.semibold)
			}
			.minimumScaleFactor(0.9)
			.foregroundColor(.white)
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal)
			
		}
	}
}

struct CityTextView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Dalmine"), isCityTextViewSelected: .constant(false), provinceAndCountry: "Lombardia, Italia")
			}
			
			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Cazzano Sant'Andrea"), isCityTextViewSelected: .constant(false), provinceAndCountry: "Lombardia, Italia")
			}
			
			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Desenzano sul Borbonico borgo"), isCityTextViewSelected: .constant(false), provinceAndCountry: "Lombardia, Italia")
			}
			
		}
	}
}

