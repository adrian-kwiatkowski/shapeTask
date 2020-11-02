import Foundation

enum WeatherType: String, Decodable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case partlyCloudyDay = "partly-cloudy-day"
    case partyCloudyNight = "partly-cloudy-night"
    case cloudy
    case rain
    case sleet
    case snow
    case wind
    case fog
    
    var emoji: String {
        switch self {
        case .clearDay:
            return "☀️"
        case .clearNight:
            return "🌙"
        case .partlyCloudyDay:
            return "⛅️"
        case .partyCloudyNight:
            return "🌙☁️"
        case .cloudy:
            return "☁️"
        case .rain:
            return "🌧"
        case .sleet:
            return "💦❄️"
        case .snow:
            return "🌨"
        case .wind:
            return "💨"
        case .fog:
            return "🌫"
        }
    }
}
