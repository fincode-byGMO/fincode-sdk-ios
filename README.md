# Fincode iOS SDK

FincodeSDKを使用すると、iOSアプリで決済、カード登録・更新・一覧取得が簡単に構築できます。

目次
=================

   * [リリース](#リリース)
   * [要件](#要件)
   * [導入](#導入)
   * [コンポーネント](#コンポーネント)
   * [表示設定](#表示設定)
   * [Repository](#repository)
   * [Licenses](#licenses)
<br>

## リリース

FincodeSDを手動でリンクするには、 [リリース ※TODO タグ付けページのリンクに置き換える](https://www.google.com) ページのバージョンを使用して、xcframeworkまたはFincodeSDKプロジェクトを追加してください。

- FincodeSDK.xcframework

手動でリンクする方法は、こちらの[導入](#導入)を行ってください。

## 要件

FincodeSDKは、iOS SDK 11以降/Swift4以降が必要です。

## 導入
FincodeSDKを利用するには、FincodeSDK.xcframeworkまたはFincodeSDKプロジェクトを組み込むことが必要です。

- xcframeworkの組み込み
    1. 任意の場所にFincodeSDK.xcframeworkを配置します。
    2. Xcodeでプロジェクトファイルを選択し「General > Frameworks」にFincodeSDK.xcframeworkを追加します。

- プロジェクトの組み込み
    1. 任意の場所にFincodeSDKのプロジェクトを配置します。
    2. 「Add Files to {プロジェクト名}」を選択しFincodeSDKのプロジェクトを追加します。
    3. Xcodeでプロジェクトファイルを選択し「General > Frameworks」にFincodeSDKプロジェクトが内包するFincodeSDK.frameworkを追加します。

## コンポーネント
- 配置

    コンポーネントの配置は、StoryboardにUIViewを配置しIdentity Inspectorに以下の値を設定します。

    - `Vertical Layout`

    |Class|Module|
    |:--:|:--:|
    |FincodeVerticalView|FincodeSDK|

    - `Horizontal Layout`

    |Class|Module|
    |:--:|:--:|
    |FincodeHorizontalView|FincodeSDK|

- 初期化

    - 決済実行 - 実装例

    ```swift
    import FincodeSDK

    class VerticalViewController: UIViewController, ResultDelegate {
        
        @IBOutlet weak var fincodeVerticalView: FincodeVerticalView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let config = FincodePaymentConfiguration()
            config.authorizationPublic = .Bearer(apiKey: "apiKey")
            config.apiVersion = "20211001"
            config.accessId = "accessId"
            config.id = "id"
            config.payType = "payType"
            config.customerId = "customerId"
            config.termUrl = "termUrl@com"
            fincodeVerticalView.configuration(config, delegate: self)
        }
        
        func success(_ result: FincodeResponse) {
            // 正常
        }

        func failure(_ result: FincodeErrorResponse) {
            // 異常
        }
    }
    ```

    処理成功時の結果は、以下のClassでキャストすることで参照することができます。

    |3DS1.0有無|Class|説明|
    |:--|:--|:--|
    |無し|FincodePaymentResponse|決済実行APIのResponse情報を保持|
    |有り|FincodePaymentSecureResponse|認証後決済APIのResponse情報を保持|

    - カード登録

    ```swift
    import FincodeSDK

    class VerticalViewController: UIViewController, ResultDelegate {
        
        @IBOutlet weak var fincodeVerticalView: FincodeVerticalView!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            let config = FincodeCardRegisterConfiguration()
            config.authorizationPublic = .Bearer(apiKey: "apiKey")
            config.apiVersion = "20211001"
            config.customerId = "customerId"
            config.defaultFlag = .ON
            fincodeVerticalView.configuration(config, delegate: self)
        } 

        func success(_ result: FincodeResponse) {
            // 正常
        }

        func failure(_ result: FincodeErrorResponse) {
            // 異常
        }
    }
    ```

    処理成功時の結果は、以下のClassでキャストすることで参照することができます。

    |Class|説明|
    |:--|:--|
    |FincodeCardRegisterResponse|カード登録APIのResponse情報を保持|

    - カード更新

    ```swift
    import FincodeSDK

    class VerticalViewController: UIViewController, ResultDelegate {
        
        @IBOutlet weak var fincodeVerticalView: FincodeVerticalView!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            let config = FincodeCardUpdateConfiguration()
            config.authorizationPublic = .Bearer(apiKey: "apiKey")
            config.apiVersion = "20211001"
            config.customerId = "customerId"
            config.cardId = "cardId"
            config.defaultFlag = .ON
            
            fincodeVerticalView.configuration(config, delegate: self)
        }

        func success(_ result: FincodeResponse) {
            // 正常
        }

        func failure(_ result: FincodeErrorResponse) {
            // 異常
        }
    }
    ```

    処理成功時の結果は、以下のClassでキャストすることで参照することができます。

    |Class|説明|
    |:--|:--|
    |FincodeCardUpdateResponse|カード更新APIのResponse情報を保持|

## 表示設定
XcodeのAttributes Inspectorを開き、以下のプロパティを変更することで表示・非表示を切り替えます。

|Property|説明|
|:--|:--|
|HeadingHidden|各欄の見出しをON：表示、OFF：非表示|
|DynamicLogDisplay|ブランド画像 動的切り替えをON：表示、OFF：非表示|
|HolderNameHidden|名義人名欄をON：表示、OFF：非表示|
|PayTimesHidden|お支払い回数欄をON：表示、OFF：非表示|

## Repository
FincodeSDKは、以下のAPIを実行するメソッドを用意しています。

|API|Class|Method|
|:--|:--|:--|
|決済実行|FincodePaymentRepository|func payment(_ id: String, request: FincodePaymentRequest, header: [String: String], complete: @escaping (_ result: FincodeApiResult<FincodePaymentResponse>) -> Void)|
|認証後決済|FincodePaymentRepository|func payment(_ id: String, request: FincodePaymentSecureRequest, header: [String: String], complete: @escaping (_ result: FincodeApiResult<FincodePaymentSecureResponse>) -> Void)|
|カード_一覧取得|FincodeCardOperateRepository|func cardInfoList(_ customerId: String, header: [String: String], complete: @escaping (_ result: FincodeApiResult<FincodeCardInfoListResponse>) -> Void)|
|カード_登録|FincodeCardOperateRepository|func registerCard(_ customerId: String, request: FincodeCardRegisterRequest, header: [String: String], complete: @escaping (_ result: FincodeApiResult<FincodeCardRegisterResponse>) -> Void)|
|カード_更新|FincodeCardOperateRepository|func updateCard(_ customerId: String, cardId: String, request: FincodeCardUpdateRequest, header: [String: String], complete: @escaping (_ result: FincodeApiResult<FincodeCardUpdateResponse>) -> Void)|

- 決済実行 - 例

```swift
let header = ["Content-Type":"application/json", "Authorization":"Bearer xxx"]
 
let request = FincodePaymentRequest()
--- パラメータ設定 省略 ---
 
FincodePaymentRepository.sharedInstance.payment("orderId", request: request, header: header) { result in
    switch result {
    case .success(let data):
        // 正常
    case .failure(let error):
        // 異常
    }
}
```

- 認証後決済 - 例

```swift
let header = ["Content-Type":"application/json", "Authorization":"Bearer xxx"]
 
let request = FincodePaymentSecureRequest()
--- パラメータ設定 省略 ---
 
FincodePaymentRepository.sharedInstance.payment("orderId", request: request, header: header) { result in
    switch result {
    case .success(let data):
         // 正常
    case .failure(let error):
         // 異常
    }
}
// ※FincodePaymentSecureRequest.paRes 変数に設定する値は、URLエンコードが必要です。
```

- カード_一覧取得 - 例

```swift
let header = ["Content-Type":"application/json", "Authorization":"Bearer xxx"]
 
FincodeCardOperateRepository.sharedInstance.cardInfoList("customerId", header: header) { result in
    switch result {
    case .success(let data):
          // 正常
    case .failure(let error):
          // 異常
    }
}
```

- カード_登録 - 例

```swift
let header = ["Content-Type":"application/json", "Authorization":"Bearer xxx"]
 
let request = FincodeCardRegisterRequest()
--- パラメータ設定 省略 ---
 
FincodeCardOperateRepository.sharedInstance.registerCard("customerId", request: request, header: header) { result in
    switch result {
    case .success(let data):
        // 正常
    case .failure(let error):
        // 異常
    }
}
```

- カード_更新 - 例

```swift
let header = ["Content-Type":"application/json", "Authorization":"Bearer xxx"]
 
let request = FincodeCardUpdateRequest()
--- パラメータ設定 省略 ---
 
FincodeCardOperateRepository.sharedInstance.updateCard("customerId", cardId: "cardId", request: request, header: header) { result in
    switch result {
    case .success(let data):
         // 正常
    case .failure(let error):
         // 異常
    }
}
```

## Licenses

- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON/blob/master/LICENSE)
- [Alamofire](https://github.com/Alamofire/Alamofire/blob/master/LICENSE)
