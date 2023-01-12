import UIKit

import SnapKit

final class BackupTableViewCell: BaseTableViewCell {
    let fileNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.medium.rawValue, size: 15)
        return view
    }()
    let fileSizeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.medium.rawValue, size: 13)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [fileNameLabel, fileSizeLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        fileSizeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(-16)
        }
        
        fileNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(16)
            make.trailing.lessThanOrEqualTo(fileSizeLabel.snp.leading).offset(-8)
        }
    }
    
}
