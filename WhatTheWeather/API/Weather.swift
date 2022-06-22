//Внутри этой структуры мы будем хранить данные модели, которую наша View model будет использовать чтобы отображать в UI

import Foundation

public struct Weather {
    let city: String
    let temperature: String
    let feelsLike: String
    let windSpeed: String
    let description: String
    let iconName: String
    
    init(response: APIResponse) {
        city = response.name
        temperature = "\(Int(response.main.temp))"
        feelsLike = "\(Int(response.main.feels_like))"
        windSpeed = "\(response.wind.speed)"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
