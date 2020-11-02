import UIKit
import RxSwift
import RxCocoa

typealias WeatherDataViewControllerCell = UITableViewCell

class HourlyDataViewController: ViewController<TableView<WeatherDataViewControllerCell, TableViewHeaderFooterView>, HourlyDataViewModel> {
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.city.name
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        viewModel.fetchData(for: datePicker.epochTime)
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        viewModel.fetchData(for: datePicker.epochTime)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func bindData() {
        viewModel.hourlyData.asDriver()
            .drive(mainView.tableView.rx.items(cellIdentifier: WeatherDataViewControllerCell.reuseIdentifier,
                                               cellType: WeatherDataViewControllerCell.self)) { _, element, cell in
                cell.textLabel?.text =  "\(element.hour) - \(element.icon.emoji) \(element.summary) - \(Int(element.temperature))°C"
            }
            .disposed(by: viewModel.disposeBag)
        
        mainView.tableView.rx
            .modelSelected(HourlyData.self)
            .bind(onNext:  { [weak self] hourlyData in
                self?.viewModel.hourlyDataTapped(hourlyData)
            })
            .disposed(by: viewModel.disposeBag)
        
        viewModel.isPerformingNetworkOperation.asDriver()
            .drive(onNext: { [weak self] in
                $0 ? self?.mainView.showSpinner() : self?.mainView.hideSpinner()
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.errorRelay.asDriver().drive(onNext: { [weak self] error in
            if error != nil, let datePickerTime = self?.datePicker.epochTime {
                self?.mainView.showError {
                    self?.viewModel.fetchData(for: datePickerTime)
                }
            } else {
                self?.mainView.hideError()
            }
        }).disposed(by: viewModel.disposeBag)
    }
}
