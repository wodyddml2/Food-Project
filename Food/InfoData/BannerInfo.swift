//
//  BannerInfo.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import UIKit

struct BannerInfo {
    let image: UIImage?
    let text: String
}

struct Banner {
    let bannerList: [BannerInfo] = [BannerInfo(image: UIImage(named: "samgyeopsal"), text: "메모를 작성해보세요!!"), BannerInfo(image: UIImage(named: "burger"), text: "맛집을 탐색해 보세요 :)"), BannerInfo(image: UIImage(named: "sushi"), text: "맛집을 찜해보세요~")]
    
}

