import UIKit

class HourlyDataTableViewCell: TableViewCell<CellContent> {
    
    private let hourLabel = UILabel(font: UIFont.monospacedDigitSystemFont(ofSize: 1.5 * UIFont.systemFontSize, weight: .regular))
    private let weatherTypeEmoji = UILabel(font: UIFont.preferredFont(forTextStyle: .largeTitle))
    private let summaryLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .body))
    private let temperatureLabel = UILabel(font: UIFont.preferredFont(forTextStyle: .title3))
    
    override func setupUI() {
        selectionStyle = .none
        contentView.addSubviews(hourLabel, weatherTypeEmoji, summaryLabel, temperatureLabel)
    }
    
    override func setupConstraints() {
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        let hourLabelLeading = hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0)
        let hourLabelVertical = hourLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        weatherTypeEmoji.translatesAutoresizingMaskIntoConstraints = false
        let emojiLeading = weatherTypeEmoji.leadingAnchor.constraint(equalTo: hourLabel.trailingAnchor, constant: 16.0)
        let emojiTop = weatherTypeEmoji.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0)
        let emojiBottom = weatherTypeEmoji.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0)
        
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        let summaryLeading = summaryLabel.leadingAnchor.constraint(equalTo: weatherTypeEmoji.trailingAnchor, constant: 16.0)
        let summaryVertical = summaryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        let temperatureLeading = temperatureLabel.leadingAnchor.constraint(greaterThanOrEqualTo: summaryLabel.trailingAnchor, constant: 16.0)
        let temperatureVertical = temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        let temperatureTrailing = temperatureLabel.trailingAnchor.constraint( equalTo: contentView.trailingAnchor, constant: -16.0)
        
        contentView.addConstraints([hourLabelLeading,
                                    hourLabelVertical,
                                    emojiLeading,
                                    emojiTop,
                                    emojiBottom,
                                    summaryLeading,
                                    summaryVertical,
                                    temperatureLeading,
                                    temperatureVertical,
                                    temperatureTrailing])
    }
    
    override func configure(with cellContent: CellContent) {
        guard let hourlyData = cellContent as? HourlyData else { return }
        
        hourLabel.text = hourlyData.hour
        weatherTypeEmoji.text = hourlyData.type.emoji
        summaryLabel.text = hourlyData.summary
        temperatureLabel.text = "\(Int(hourlyData.temperature))°C"
    }
}
