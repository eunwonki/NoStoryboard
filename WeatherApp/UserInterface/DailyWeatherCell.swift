import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.textColor = UIColor.green
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = UIColor.red
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: 16),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -10),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            dateLabel.heightAnchor.constraint(equalToConstant: 64),
            titleLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor,
                                                constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
        ])
    }
}
