import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyWeatherTableViewCell.self))
            as? DailyWeatherTableViewCell
        else {
            return UITableViewCell()
        }
        
        let month = dataSource[indexPath.row].month
        let day = dataSource[indexPath.row].day
        let title = dataSource[indexPath.row].title
        let date = "\(day). \(month)"
        cell.dateLabel.text = date
        cell.titleLabel.text = title
        return cell
    }
}
