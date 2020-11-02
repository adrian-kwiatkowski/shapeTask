import UIKit
import RxSwift
import RxCocoa

typealias CitiesViewControllerCell = TableViewCell<CellContent>

class CitiesViewController: ViewController<TableView<CitiesViewControllerCell>, CitiesViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LocalizedString.selectCity
    }
    
    override func bindData() {
        Observable.from(optional: viewModel.cities)
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items(cellIdentifier: CitiesViewControllerCell.reuseIdentifier, cellType: CitiesViewControllerCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.name
                cell.accessoryType = .disclosureIndicator
            }.disposed(by: viewModel.disposeBag)
        
        mainView.tableView.rx
            .modelSelected(City.self)
            .bind(onNext: { [weak self] city in
                self?.viewModel.cityTapped(city)
            }).disposed(by: viewModel.disposeBag)
    }
}
