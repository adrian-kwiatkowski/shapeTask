import Foundation

struct WeatherDataResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case hourly
        case data
    }
    
    let hourly: [HourlyData]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let hourlyContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .hourly)
        
        hourly = try hourlyContainer.decode([HourlyData].self, forKey: .data)
    }
}
