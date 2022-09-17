import UIKit

import SnapKit

class PageView: BaseView {
    
    let onboardingImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()
    
    let onboardingTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "맛집을 탐방해보세요!!"
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let onboardingIntroLabel: UILabel = {
        let view = UILabel()
        view.text =
        """
        안녕하세요.
        이 앱은 쉽게 맛집을 탐색하고
        맛있는 음식을 탐색하기 위한 블라블라
        """
        view.numberOfLines = 0
        view.textAlignment = .center
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
            make.height.equalTo(UIScreen.main.bounds.height / 3.5)
        }
        
        onboardingTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingImageView.snp.bottom).offset(45)
            make.centerX.equalTo(self)
        }
        
        onboardingIntroLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingTitleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(UIScreen.main.bounds.width / 1.6)
        }
    }
}


