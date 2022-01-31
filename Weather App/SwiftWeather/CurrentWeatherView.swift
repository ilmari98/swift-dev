//
//  CurrentWeatherView.swift
//  Weather App
//
//  Created by Ilmari Lehmusjärvi on 31.1.2022.
//

import Foundation
import Combine

final class CurrentWeatherViewModel: ObservableObject {
    @Published var current: Weather?
     init() {
         self.fetch()

     }
}

extension CurrentWeatherViewModel {
    func fetch(by city: String = "Lappeenranta") {
        WeatherApi.fetchCurrentWeather(by: city) {
            self.current = $0
            }
     }
}
