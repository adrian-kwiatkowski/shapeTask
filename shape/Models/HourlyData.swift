import Foundation

struct HourlyData: CellContent, Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case time
        case summary
        case type = "icon"
        case temperature
    }
    
    private let time: Int
    let summary: String
    let type: WeatherType
    let temperature: Float
    
    var hour: String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let calendar = Calendar.current
        let hourDigit = calendar.component(.hour, from: date)
        let hourString = String(format: "%02d", hourDigit)
        return "\(hourString):00"
    }
}
