// В этом файле мы будем получать данные из нашего WeatherService и конвертировать их в данные для нашего WeatherView

//@Published свойства здесь для того, чтобы после изменения этих свойств наша View будет сразу же меняться

// 1* Этот метод вызывает метод из WeatherService для загрузки данных о погоде, и после получения этих данных ViewModel обновит наши четыре свойства @Published, которые будут использоваться средством просмотра для отправки данных

// 2* Поскольку эти свойства влияют на UI, мы должны убедиться, что они обновлены в правильной очереди

import Foundation

private let defaultIcon = "❓"
private let iconMap = [
  "Drizzle" : "🌧",
  "Thunderstorm" : "⛈",
  "Rain": "🌧",
  "Snow": "❄️",
  "Clear": "☀️",
  "Clouds" : "☁️",
]

public class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var feelsLike: String = "--"
    @Published var windSpeed: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    @Published var shouldShowLocationError: Bool = false

    let weatherService: WeatherService

     init(weatherService: WeatherService) {
       self.weatherService = weatherService
     }
    
    public func refresh() { // 1*
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async { // 2*
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)°C"
                self.feelsLike = "\(weather.feelsLike)°C"
                self.windSpeed = "\(weather.windSpeed)m/s"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
}
