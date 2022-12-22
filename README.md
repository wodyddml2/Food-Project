# 아맛다 - 아주 맛있는 다이어리

<img width="983" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-11-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7 22 38" src="https://user-images.githubusercontent.com/83345066/208294338-4de941f5-1865-45a1-aca6-bf2f0c0fc82e.png">

> **Introduction**
> 
- 1인 출시 프로젝트(기획, 개발, 출시)
- 출시 기간 약 3주(2022.09.08 ~ 2022.09.29)
- 주변 맛집을 간편하게 찾고 기억에 남는 맛집을 기록을 하는 앱

<br/><br/>
> **Stack**
> 
- Swift, UIKit, SnapKit, CoreLocation, NMapsMap, PHPicker, UIImagePicker, FileManager, Network
- TOCropViewController, Zip, Acknowlist, IQKeyboardSwift
- Alamofire, SwiftyJson, Realm, Codable
- FirebaseAnalytics(Crashlytics)
- MVC, Singleton Pattern
- SPM, CocoaPods

<br/><br/>
> **프로젝트 기능**
> 
- 지도와 검색을 이용해 주변 맛집 정보 제공
- 검색한 맛집 찜 목록 추가, 삭제
- 맛집 정보와 리뷰 저장, 삭제, 수정
- 음식 사진 편집, 저장, 삭제, 수정
- 메모 목록 최신순, 별점순, 방문순 정렬
- 음식 카테고리 추가, 삭제
- 백업, 복구 기능

<br/><br/>
> **프로젝트 기술 적용**
>
- **네이버 지도 SDK**와 **카카오 로컬 API**를 통해 맛집 정보 표시
- **Realm** **Database** CRUD, 정규화
- **Realm** **migration** 작업을 통한 버전 관리
- **FileManager**를 통해 Document 폴더 접근
    - 이미지  CRUD
    - **Codable**로 데이터 형식 변환과 **Zip**의 파일 압축, 압축 해제를 통해 백업, 복구
- **PHPickerController, UIImagePickerController** 앨범, 카메라 접근
- **TOCropViewController** 사진 편집
- **Network** Framework을 이용해 실시간 모니터링으로 네트워크 연결 상태 체크 및 대응
- **WebView**로 맛집 상세 정보 페이지 구현
- **FirebaseAnalytics(Crashlytics)** 사용자의 활동 정보 통계와 특정 이벤트 수집, 실시간 분석을 통해 사용자들의 불편 최소화

<br/><br/>
> **개발 공수**
> 
- 개발 기간: 2022.09.08 ~ 2022.09.29 (약 3주) - 기획, 디자인, 개발, 출시, 업데이트 등

|                       진행 사항 |                       진행 기간 |                       세부 내역 |
| --- | --- | --- |
| 기획 및 디자인 초안  | 2022.09.08~2022.09.12 | 앱 아이디어 구상, 비슷한 앱들 분석, UI 구상, 일정 기획, 기획 발표 |
| 전체적인 UI 틀 구현 | 2022.09.12 ~ 2022.09.14 | 전체적인 UI 틀 구현 |
| 지도 탭 기능 구현, 팝업 화면 기능 구현 | 2022.09.14 ~ 2022.09.16 | API 호출 메서드로 HTTP 통신, CoreLocation을 통해 위치 정보 활용, 네이버지도 라이브러리 사용 |
| 검색 기능, 찜 기능 구현, 메모 추가 기능 구현  | 2022.09.17 ~ 2022.09.19 | 페이지네이션을 통해 API 호출, 데이터 스키마 구상 후 Realm을 이용해 찜 데이터 저장, 삭제 기능, 메모 저장 기능 구현 |
| 메모 및 이미지  수정, 삭제, 저장 기능, 홈 탭 기능 구현 | 2022.09.20 ~ 2022.09.22 | FileManage로 Document에 접근해 이미지 저장, 수정 ,삭제 기능 구현, 메모 수정, 삭제 기능 구현, Home 베너 기능, 카테고리 별 메모 목록 tableView, collectionView를 이용하여 구현  |
| 버그 수정, font, 색상, 아이콘 적용  | 2022.09.23 ~ 2022.09.25 | 버그 수정, font, 색상, 아이콘 적용  |
| 버그 수정, 설정 탭 기능 구현, 권한 처리 대응, 네트워크 예외 처리, 앱 출시 | 2022.09.26 ~ 2022.09.29 | 버그 수정, 카테고리 추가 삭제 기능, 오픈소스 라이선스 명시, (문의사항, 리뷰) 기능 추가, (카메라, 갤러리, 위치) 권한 처리, 네트워크 예외 처리, 목업 이미지 준비, 앱에 대한 설명, 개인 정보 처리 방침 |
| 앱 업데이트  | 2022.09.30 ~ | 백업 복구 기능, 메모 작성 화면 개선, 지도 버그 개선, 찜 버튼 클릭 시 중복 저장 문제 개선, 키보드 문제 개선 |
| Reject | 2022.10.07 | 카메라 권한 처리 문구 수정 |

<br/><br/>
<br/><br/>
> **Trouble Shooting**
> 

▶︎  **앱 심사 리젝 사유 - 5.1.1 Legal: Privacy - Data Collection and Storage**
<img width="530" alt="스크린샷 2022-12-22 오후 6 01 23" src="https://user-images.githubusercontent.com/83345066/209108283-69d636fb-7a8b-49d0-bf6a-a37578217382.png">
<img width="345" alt="스크린샷 2022-12-22 오후 6 01 31" src="https://user-images.githubusercontent.com/83345066/209108420-96660805-00c8-4d26-a924-0ef672ff6fd1.png">
Apple 앱 심사에서 카메라 권한 문구의 설명이 충분하지 않다는 Reject 사유를 전달받음

‘카메라를 사용하기 위해’ 라는 모호한 문구 보다는 Apple 앱 심사 지침에 맞는 더 명확한 표현을 위해 카메라가 어디에 사용이 될 것인지를 나타낼 수 있게끔 ‘음식 다이어리 작성을 위해’ 라는 문구로 변경하여 재심사 통과

처음 진행하는 앱 출시 과정에서 Reject을 받는 중요한 경험을 하였고 가볍게 지나칠 수 있는 권한 처리 문구들을 사용자들 입장에서 무슨 목적인지 한 눈에 알아볼 수 있도록 세심하게 체크하는 과정이 필요하다는 것을 배움
<br/><br/>
▶︎  **Annotation 겹치는 현상**

<img width="184" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-12-14_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10 44 16" src="https://user-images.githubusercontent.com/83345066/208294314-9cb64573-42fd-4f7a-8f11-8b57302dc797.png">

```swift
private func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
					...
					case .authorizedWhenInUse:
	          locationManager.distanceFilter = 100000
            locationManager.startUpdatingLocation()
					...
		}
}
```

**startUpdatingLocation()** 함수가 여러번 호출되면서 Annotation이 중복 생성이 되어 Annotation의 바뀐 색상이 보이지 않는 이슈

CLLocationManager 클래스의 프로퍼티인 **distanceFilter**를 사용해 지정해준 거리(m)만큼의 위치 변화가 생겼을 때 **startUpdatingLocation()**가 호출되도록 지정 거리를 설정하여 해결

만약 Annotation이 겹치는 문제가 없었다면 불필요한 **startUpdatingLocation()** 함수의 호출이 없다고 생각 했을텐데

이 이슈로 인해 distanceFilter 프로퍼티의 기능 뿐만 아니라 이런 불필요한 함수 호출을 체크하고 막아 앱의 성능을 개선을 시킬 수 있는 역량을 키울 수 있었음
<br/><br/>
▶︎  **UITableView의 section별 UICollectionView 설정 시 화면 중복, scroll 문제** 
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reusableIdentifier, for: indexPath) as? MemoListTableViewCell else {
        return UITableViewCell()
     }
		 ...
		 cell.collectionView.tag = indexPath.section
	   cell.collectionView.reloadData()
		 return cell
 }

// UITableViewCell File
override func prepareForReuse() {
     super.prepareForReuse()
     collectionView.reloadData()
}
```

**UITableView** 안의 **UICollectionView**의 화면이 그려지는 과정에서 특정 section의 UICollectionView를 scroll(horizontal)시 다른 section에서 같이 scroll되는 이슈, 각 section별로 다르게 그려져야하는 UICollectionView가 중복되어 그려지는 이슈

UITableViewCell의 재사용하기 전 시점인 **prepareForReuse**에서 collectionView를 **reload**해줌으로써 scroll을 원위치 시키고 **UITableViewCell을 재사용하여 그려주는 시점**에서 collectionView를 **reload**해줌으로써 section 별 collectionView를 그려줘 문제를 해결

UITableViewCell 안에 UICollectionView를 넣어주어 cell의 재사용이 많은 코드에서는 각 적절한 시점에서 cell을 다시 그려주는 작업이 필요하다는 것을 알게되면서 문제를 해결하기 위해 tableViewCell과 collectionViewCell의 LifeCycle에 대해 다시 공부하면서 시점에 대한 처리를 더욱 유연하게 다룰 수 있게 됨
<br/><br/>
▶︎  **카테고리 삭제 시 메모 목록에서 index error**
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reusableIdentifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
				...
        if indexPath.row == indexPath.first {
            cell.isHidden = true
        } else {
            cell.isHidden = false
        }
        ...
        return cell
    }

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return indexPath.row == indexPath.first ? 0 : 50
}

// swipe
func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            if indexPath.row != indexPath.first {
                if let tasks = self.categoryTasks {
                    do {
                        try self.repository.fetchUpdate {
                            self.repository.fetchCategory(category: tasks[indexPath.row].objectId).forEach { memo in
                                guard let task = tasks.first else {return}
                                memo.storeCategory = task.objectId
                            }
                        }
                    } catch {
                        self.showCautionAlert(title: "카테고리 삭제에 실패했습니다.")
                    }
                  ... 
                }
                ...
            }
        }
        ...
        return UISwipeActionsConfiguration(actions: [delete])
    }
```

카테고리 목록에서 카테고리 삭제 했을 때 카테고리 별로 맛집 메모를 분류한 Home 화면에서 **index error**가 발생

삭제된 카테고리의 메모 데이터 객체를 Home 화면에서 불러오는 로직을 고려하지 못해 발생한 문제 였던 것

하나의 **기본 카테고리**를 생성하고 기본 카테고리는 **삭제 시키지 못하도록 카테고리 관리 화면**에서 해당 **cell을 hidden 처리**
**이외 카테고리 삭제** 시 해당 메모의 데이터들을 **기본 카테고리로 이동**시키도록 **DB를 업데이트 처리**하여 해결

사용자 입장과 로직을 충분히 고려하지 못해 발생한 이슈로 맛집 메모가 들어있는 카테고리를 삭제할 때는 error를 잡는 것뿐만 아니라 어떻게 처리를 해줘야 사용자 입장에서 불편함을 느끼지 않을 수 있을까 고민하고 해결하는 시간을 가지면서 사용자의 입장을 고려할 수 있는 개발자의 역량을 키울 수 있게 됨
<br/><br/>
> **UI 초안**
> 

https://www.figma.com/file/NplxckTKwBDybqAUmF7ylf/SeSAC-%EA%B0%9C%EC%9D%B8-%EC%95%B1-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8?node-id=0%3A1

<img width="618" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-11-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7 13 33" src="https://user-images.githubusercontent.com/83345066/208294257-c4c5370d-81e9-4290-a62b-242afc5e566b.png">

<br/><br/>
> **Version Update**
> 

**1.0.0**

- 2022.09.30 출시

**1.1.1**

- 2022.10.07 업데이트
- 백업 / 복구 기능 추가
- 지도 화면 - Pin이 중복되어 custom한 색상이 가려지는 버그 수정
- 메모 작성 화면 - 기타 버그 수정

**1.1.2**

- 2022.10.20 업데이트
- 찜 목록에 추가 시 중복 추가 문제 개선

**1.1.3**

- 2022.11.01 업데이트
- Firebase Analytics, Firebase Crashlytics 적용

**1.1.4**

- 2022.12.12 업데이트
- IQKeyboard를 적용하여 키보드 window를 내릴 시 임의로 올린 화면이 깨지는 부분 수정

