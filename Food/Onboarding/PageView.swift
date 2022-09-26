import UIKit

import SnapKit

final class PageView: BaseView {
    
    let onboardingImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: SetColor.lightPink.rawValue)
        view.image = UIImage(named: "samgyeopsal")
        return view
    }()
    
    let onboardingTitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .boldSystemFont(ofSize: 16)
        view.textAlignment = .center
        return view
    }()
    
    let onboardingIntroLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        view.textColor = .lightGray
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [onboardingImageView, onboardingTitleLabel, onboardingIntroLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(self)
            make.width.equalTo(UIScreen.main.bounds.width / 1.5)
            make.height.equalTo(UIScreen.main.bounds.height / 2.5)
        }
        
        onboardingTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingImageView.snp.bottom).offset(45)
            make.centerX.equalTo(self)
            make.trailing.equalTo(onboardingImageView.snp.trailing).offset(-20)
            make.leading.equalTo(onboardingImageView.snp.leading).offset(20)
        }
        
        onboardingIntroLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingTitleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.trailing.equalTo(onboardingImageView.snp.trailing).offset(-30)
            make.leading.equalTo(onboardingImageView.snp.leading).offset(30)
        }
    }
}


