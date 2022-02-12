//
//  WeatherDetailsViewModel.swift
//  Weather displayer
//
//  Created by Federico Imberti on 12/02/22.
//

import UIKit
import SwiftUI

class WeatherDetailsViewModel: ObservableObject {

	@Binding var isSheetShown:Bool
	var day:Day
	
	init(isSheetShown: Binding<Bool>, day: Day) {
		self._isSheetShown = isSheetShown
		self.day = day
	}

	func isSubtitlePresent() -> Bool{
		return day.conditions!.count == 2
	}

}
