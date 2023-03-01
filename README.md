# 아맛다 - 아주 맛있는 다이어리

<img width="983" alt="%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2022-11-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_7 22 38" src="https://user-images.githubusercontent.com/83345066/208294338-4de941f5-1865-45a1-aca6-bf2f0c0fc82e.png">

## 💁🏻‍♂️ **Introduction**

- 1인 출시 프로젝트(기획, 개발, 출시)
- 출시 기간 약 3주(2022.09.08 ~ 2022.09.29)
- 주변 맛집을 간편하게 찾고 기억에 남는 맛집을 기록을 하는 앱
- 지도와 검색을 이용해 주변 맛집 정보를 제공합니다
- 원하는 맛집을 찜할 수 있습니다
- 맛집에 대해 기록, 수정이 가능합니다
- 데이터 백업 복구가 가능합니다
<br></br>

## ⚙️ **Stack**
> 기술 및 라이브러리
> 
- Swift, UIKit, SnapKit, CoreLocation, NMapsMap, PHPicker, UIImagePicker, FileManager, Network
- RxSwift, RxCocoa
- TOCropViewController, Zip, Acknowlist, IQKeyboardSwift
- Alamofire, SwiftyJson, Realm, Codable
- FirebaseAnalytics(Crashlytics)
- MVC, MVVM, Singleton Pattern
- SPM, CocoaPods


<br/><br/>
> 프로젝트 기술 적용
>
- **Database**
    - **Realm** Database **CRUD**, **정규화** 및 **migration** 작업을 통한 버전 관리
- **Design Pattern**
    - **Singleton** 패턴으로 하나의 객체만을 생성해 메모리 낭비 방지
    - **Delegate** 패턴을 통해 데이터 전달
- **Main View**
    - **UITableView 내부에 UICollectionView** 삽입을 통한 복잡한 layout 처리
    - **Timer**를 이용해 UICollectionView 자동 스크롤
- **Map View**
    - **네이버 지도 SDK**와 **카카오 로컬 API**를 통해 맛집 정보 표시
    - location **authorizationStatus**에 따라 분기 처리
    - 현재 UICollectionViewCell index 값에 따라 Annotation 색상 표시
- **Search View**
    - 검색 시 **카카오 로컬 API**를 통해 음식점 정보 **GET**
- **Restaurant** **Information View**
    - **WebView**로 맛집 상세 정보 페이지 구현
- **MeMo View**
    - Realm **쿼리 연산자**를 이용한 **Filter** 처리로 메모 정렬
- **MeMo Write View**
    - **PHPickerController, UIImagePickerController** 앨범, 카메라 접근
    - **TOCropViewController** 사진 편집을 통한 이미지 리사이징
    - 검색을 통한 음식점 상호명, 주소 입력으로 사용자 불편 최소화
    - 카테고리 별 저장
- **FileManager**를 이용해 json 형식의 압축 파일 백업, 복구
- **Network** Framework을 이용해 실시간 모니터링으로 네트워크 연결 상태 체크 및 대응

<br/><br/>
> Refactoring
>
- **MVVM** 패턴을 이용한 비즈니스 로직 분리
- **RxSwift**, **RxCocoa**를 이용해 데이터 스트림을 비동기적인 흐름으로 처리

<br/><br/>
## 📝 개발 공수 
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
## ⚒ **Trouble Shooting**


> **앱 심사 리젝 사유 - 5.1.1 Legal: Privacy - Data Collection and Storage**
> 
<img width="530" alt="스크린샷 2022-12-22 오후 6 01 23" src="https://user-images.githubusercontent.com/83345066/209108283-69d636fb-7a8b-49d0-bf6a-a37578217382.png">
<img width="345" alt="스크린샷 2022-12-22 오후 6 01 31" src="https://user-images.githubusercontent.com/83345066/209108420-96660805-00c8-4d26-a924-0ef672ff6fd1.png">
Apple 앱 심사에서 카메라 권한 문구의 설명이 충분하지 않다는 Reject 사유를 전달받음

‘카메라를 사용하기 위해’ 라는 모호한 문구 보다는 Apple 앱 심사 지침에 맞는 더 명확한 표현을 위해 카메라가 어디에 사용이 될 것인지를 나타낼 수 있게끔 ‘음식 다이어리 작성을 위해’ 라는 문구로 변경하여 재심사 통과

처음 진행하는 앱 출시 과정에서 Reject을 받는 중요한 경험을 하였고 가볍게 지나칠 수 있는 권한 처리 문구들을 사용자들 입장에서 무슨 목적인지 한 눈에 알아볼 수 있도록 세심하게 체크하는 과정이 필요하다는 것을 배움

<br><br/>
>  **Annotation 겹치는 현상**
>  

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

<br><br/>
>  **UITableView의 section별 UICollectionView 설정 시 화면 중복, scroll 문제** 
>  
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

<br><br/>
> 카테고리 삭제 시 메모 목록에서 index error
> 
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
<br><br/>

## ⭐️ Version Update


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

<br/><br/>
## 🔥 프로젝트 회고

첫 앱스토어 출시 프로젝트를 하면서 처음으로 기획과 디자인, 개발을 모두 진행하게 되었다.
진행 도중에 기획과 디자인 변경을 여러번 겪게 되었고 중간에 발생하는 변경사항에 대해 대처하는 법을 배울 수 있었다.
또한 다시 한 번 프로젝트의 코드를 돌아보며 처리하지 못한 아쉬운 부분들을 생각해 볼 수 있었다.

1. 중복 코드
    
    출시 기한에 맞춰 프로젝트 완성을 하려다보니 중복적인 코드를 여러개 볼 수 있었다.
    그렇다보니 코드도 지저분해지고 유지보수 측면에서도 비효율적이게 되었기 때문에 따로 extension에 정리를 해놓거나 BaseVC에 따로 정리해서 가독성과 유지보수 측면에서 효율을 늘려야겠다.
    
2. 폴더링
    
    프로젝트 진행하면서 폴더링을 처음 해보다보니 좀 더 세분화된 깔끔한 폴더링을 진행하지 못한 것 같다.
    협업 시 팀원이 알아보기 쉽도록 각 역할에 맞게 더욱 세분화해서 폴더링을 해야겠다.
    
3. 문자열 처리
    
    자주 사용하는 문자열을 다른 처리 없이 사용한 흔적들을 여러 곳에서 볼 수 있었다.
    이렇게되면 나중에 해당 문자열을 수정 시 하나씩 모두 처리를 해줘야하기에 유지보수 측면에서 상당히 비효율적일 것이기 때문에 효율적인 관리를 위해 enum으로 문자열을 묶어 보완을 해야겠다.
    
4. MVC 패턴
    
    MVC 패턴의 View의 역할을 하는 것은 View의 파일에서 로직을 모두 처리해야하는데 그런 부분들을 제대로 처리하지 못한 부분들이 있었다.
    패턴의 구조와 역할을 제대로 이해하고 로직을 처리할 수 있도록 다시 공부하고 보완을 해야겠다.
    
    또한 MVC 패턴은 뷰컨트롤러의 역할이 너무 커지는 것 같기에 다음에는 비즈니스 로직을 따로 분리할 수 있도록 MVVM 패턴을 공부하고 적용시켜봐야겠다.
