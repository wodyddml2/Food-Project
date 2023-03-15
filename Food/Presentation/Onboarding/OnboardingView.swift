import UIKit

import SnapKit

final class OnboardingView: BaseView {
    
    let onboardingImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let onboardingTitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .gothicNeo(.SemiBold)
        view.textAlignment = .center
        return view
    }()
    
    let onboardingIntroLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .gothicNeo(size: 14)
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
            make.width.equalTo(UIScreen.main.bounds.width / 1.1)
            make.height.equalTo(UIScreen.main.bounds.height / 2.3)
        }
        
        onboardingTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingImageView.snp.bottom)
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


