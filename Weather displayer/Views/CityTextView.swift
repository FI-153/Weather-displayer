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
	var provinceAndCountry:String

	var body: some View {
		VStack(alignment: .leading) {
			Group{
				TextField("", text: $titleText)
					.textFieldStyle(.plain)
					.keyboardType(.asciiCapable)
					.font(.system(size: 35, weight: .bold))
					.submitLabel(.go)

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
				CityTextView(titleText: .constant("Dalmine"), provinceAndCountry: "Lombardia, Italia")
			}
			
			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Cazzano Sant'Andrea"), provinceAndCountry: "Lombardia, Italia")
			}

			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Desenzano sul Borbonico borgo"), provinceAndCountry: "Lombardia, Italia")
			}

		}
	}
}

