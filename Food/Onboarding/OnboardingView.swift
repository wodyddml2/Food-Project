import UIKit

import SnapKit

class OnboardingView: BaseView {
    
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
    
    var onboardingPageControl: UIPageControl = {
        let view = UIPageControl()

        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .black

        return view
    }()
    
    let continueButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        
        view.setTitle("Continue", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        return view
    }()
    
    let skipButton: UIButton = {
        let view = UIButton()
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(UIColor.lightGray, for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [onboardingImageView, onboardingTitleLabel, onboardingIntroLabel, onboardingPageControl, continueButton, skipButton].forEach {
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
        
        onboardingPageControl.snp.makeConstraints { make in
            make.top.equalTo(onboardingIntroLabel.snp.bottom).offset(40)
            make.centerX.equalTo(self)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(onboardingPageControl.snp.bottom).offset(40)
            make.centerX.equalTo(self)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
            make.height.equalTo(50)
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(30)
            make.centerX.equalTo(self)
        }
    }
}


