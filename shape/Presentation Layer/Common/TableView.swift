import UIKit

class TableView<Cell: TableViewCell<CellContent>>: View, UITableViewDelegate {
    
    private let spinnerView = UIActivityIndicatorView(style: .large)
    
    private let errorView = UIView()
    private let errorLabel = UILabel()
    private let errorButton = UIButton(type: .system)
    private var errorButtonAction: (( ) -> ( ))?

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func setupUI() {
        addSubview(tableView)
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        
        errorView.addSubview(errorLabel)
        errorView.addSubview(errorButton)
        
        errorButton.setTitle(LocalizedString.retry, for: .normal)
        
        errorLabel.text = LocalizedString.error
        errorLabel.textColor = .systemGray
        errorLabel.numberOfLines = 2
        errorLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        let topConstraint = tableView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        let errorLabelHorizontal = errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor)
        let errorLabelVertical = errorLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor)
        
        errorButton.translatesAutoresizingMaskIntoConstraints = false
        let errorButtonTop = errorButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 8.0)
        let errorButtonHorizontal = errorButton.centerXAnchor.constraint(equalTo: errorView.centerXAnchor)

        errorView.addConstraints([errorLabelHorizontal,
                                  errorLabelVertical,
                                  errorButtonTop,
                                  errorButtonHorizontal])
    }
    
    func showSpinner() {
        tableView.backgroundView = spinnerView
        spinnerView.startAnimating()
    }
    
    func hideSpinner() {
        spinnerView.stopAnimating()
        tableView.backgroundView = nil
    }
    
    func showError(action: @escaping (( ) -> ( )) ) {
        errorButtonAction = action
        errorButton.addTarget(self, action: #selector(errorButtonTapped), for: .touchUpInside)
        tableView.backgroundView = errorView
    }
    
    @objc private func errorButtonTapped() {
        errorButtonAction?()
    }
    
    func hideError() {
        tableView.backgroundView = nil
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
