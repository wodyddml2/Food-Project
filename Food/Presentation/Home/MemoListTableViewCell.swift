//
//  MemoListTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

final class MemoListTableViewCell: BaseTableViewCell {
    
    let memoListCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let memoListMoreLabel: UILabel = {
        let view = UILabel()
        view.text = "더보기"
        view.font = UIFont(name: SetFont.semibold.rawValue, size: 14)
        return view
    }()
    let memoListMoreImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
        return view
    }()
    var memoListMoreButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    // 잠재적인 성능 문제를 방지하려면 콘텐츠와 관련이 없는 셀의 속성만 재설정해야한다.
    override func prepareForReuse() {
        super.prepareForReuse()
        
        memoListCollectionView.reloadData()
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [memoListCollectionView,memoListMoreLabel,memoListMoreImageView,memoListMoreButton].forEach {
            contentView.addSubview($0)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    override func setConstraints() {
        memoListCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        
        memoListMoreImageView.snp.makeConstraints { make in
            make.top.equalTo(memoListCollectionView.snp.bottom).offset(4)
            make.trailing.equalTo(-8)
            make.height.equalTo(14)
            make.width.equalTo(11)
        }
        memoListMoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(memoListMoreImageView)
            make.trailing.equalTo(memoListMoreImageView.snp.leading).offset(-4)
        }
        
        memoListMoreButton.snp.makeConstraints { make in
            make.trailing.equalTo(memoListMoreImageView.snp.trailing)
            make.leading.equalTo(memoListMoreLabel.snp.leading)
            make.top.bottom.equalTo(memoListMoreImageView)
        }
        
    }
    
    
    
}
