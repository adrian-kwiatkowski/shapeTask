import UIKit
import RxSwift
import RxCocoa

typealias HourlyDataViewControllerCell = HourlyDataTableViewCell

class HourlyDataViewController: ViewController<TableView<HourlyDataViewControllerCell>, HourlyDataViewModel> {
    
    private let datePicker = UIDatePicker()
    
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
    
    override func bindData() {
        viewModel.hourlyData.asDriver()
            .drive(mainView.tableView.rx.items(cellIdentifier: HourlyDataViewControllerCell.reuseIdentifier,
                                               cellType: HourlyDataViewControllerCell.self)) { _, element, cell in
                cell.configure(with: element)
            }
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
    
    @objc private func dateChanged(sender: UIDatePicker) {
        viewModel.fetchData(for: datePicker.epochTime)
        self.dismiss(animated: true, completion: nil)
    }
}
