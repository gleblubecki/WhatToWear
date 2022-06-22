//
//  WhatTheWeatherApp.swift
//  WhatTheWeather
//
//  Created by Глеб Любецкий on 29.05.2022.
//

import SwiftUI

@main
struct WhatTheWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            WeatherView(viewModel: WeatherViewModel(weatherService: weatherService))        }
    }
}
