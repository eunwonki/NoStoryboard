import Combine
import UIKit

class ViewController: UIViewController {
    let mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 8
        return view
    }()
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        return bar
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(DailyWeatherTableViewCell.self,
                       forCellReuseIdentifier: String(describing: DailyWeatherTableViewCell.self))
        return table
    }()
    
    var viewModel = WeeklyWeatherViewModel(weatherFetcher: WeatherFetcher())
    private var disposables = Set<AnyCancellable>()
    
    var dataSource: [DailyWeatherRowViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraint()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        combineViewModel()
    }
    
    func setConstraint() {
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor,
                                               constant: 50),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                  constant: 0),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                constant: 0),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                 constant: 0)
        ])
        
        _ = [searchBar, tableView].map {
            mainStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,
                                           constant: 10)
        ])
    }
    
    func combineViewModel() {
        searchBar.searchTextField.textDidChangePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.city, on: viewModel)
            .store(in: &disposables)

        viewModel.$dataSource.sink {
            [weak self] dataSource in
            self?.dataSource = dataSource
            self?.tableView.reloadData()
        }.store(in: &disposables)
    }
}
