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

- 決済実行 - 例

```
import FincodeSDK

class VerticalViewController: UIViewController, ResultDelegate {
    
    @IBOutlet weak var fincodeVerticalView: FincodeVerticalView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = FincodePaymentConfiguration()
        config.authorizationPublic = .Bearer(apiKey: "p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample")
        config.apiVersion = "20211001"
        config.accessId = "a_B1egvGN_Rge19dO14Sample"
        config.id = "o_XqXw_hhlQAa7FFzCSample"
        config.payType = "Card"
        config.customerId = "c_HSZkCAxNS2q_7TbLcO9y1A"
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

- カード登録 - 例

```
import FincodeSDK

class VerticalViewController: UIViewController, ResultDelegate {
    
    @IBOutlet weak var fincodeVerticalView: FincodeVerticalView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = FincodeCardRegisterConfiguration()
        config.authorizationPublic = .Bearer(apiKey: "p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample")
        config.apiVersion = "20211001"
        config.customerId = "c_HSZkCAxNS2q_7TbLcO9y1A"
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

- カード更新 - 例

```
import FincodeSDK

class VerticalViewController: UIViewController, ResultDelegate {
    
    @IBOutlet weak var fincodeVerticalView: FincodeVerticalView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = FincodeCardUpdateConfiguration()
        config.authorizationPublic = .Bearer(apiKey: "p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample")
        config.apiVersion = "20211001"
        config.customerId = "c_HSZkCAxNS2q_7TbLcO9y1A"
        config.cardId = "cs_UrDeMDBlQfShg9QZsMPLE"
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

```
let header = ["Content-Type":"application/json", "Authorization":"Bearer p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample"]

// プロパティの詳細は一覧をご参照ください
let request = FincodePaymentRequest()

// 引数の詳細は一覧をご参照ください
FincodePaymentRepository.sharedInstance.payment("o_XqXw_hhlQAa7FFzCSample", request: request, header: header) { result in
    switch result {
    case .success(let data):
        // 正常
    case .failure(let error):
        // 異常
    }
}
```

- FincodePaymentRequest プロパティ一覧

|項目名|プロパティ名|必須|型|最小桁数|最大桁数|備考|
|:--|:--|:--|:--|:--|:--|:--|
|決済種別|payType|〇|String|1|50||
|取引ID|accessId|〇|String|24|24||
|オーダーID|id|〇|String|1|30||
|トークン|token|△|String|1|512|カード番号入力方式：トークン方式の場合 必須|
|カード番号|cardNo|△|String|10|16|カード番号入力方式：直接方式の場合 必須|
|有効期限|expire|△|String|4|4|カード番号入力方式：直接方式の場合 必須|
|顧客ID|customerId|△|String|1|60|カード番号入力方式：顧客ID方式の場合 必須|
|カードID|cardId|△|String|25|25|カード番号入力方式：顧客ID方式の場合 必須|
|支払方法|method||String|1|1|1：一括  2：分割|
|支払回数|payTimes||String|1|2|支払方法にて、分割を指定していた場合  必須|
|セキュリティコード|securityCode||String|4|4||
|カード名義人|holderName||String|1|50|カード番号入力方式：顧客ID方式の場合 は登録時のカード名義人が優先されます|

- 引数一覧

|引数|説明|
|:--|:--|
|id|FincodePaymentRequestのidと同値|
|request|リクエスト パラメータ|
|header|リクエスト ヘッダー|
|complete|API実行結果を処理するクロージャー|

---

- 認証後決済 - 例

```
let header = ["Content-Type":"application/json", "Authorization":"Bearer p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample"]
 
// プロパティの詳細は一覧をご参照ください
let request = FincodePaymentSecureRequest()

// 引数の詳細は一覧をご参照ください 
FincodePaymentRepository.sharedInstance.payment("o_XqXw_hhlQAa7FFzCSample", request: request, header: header) { result in
    switch result {
    case .success(let data):
         // 正常
    case .failure(let error):
         // 異常
    }
}
```

- FincodePaymentSecureRequestプロパティ一覧

|項目名|プロパティ名|必須|型|最小桁数|最大桁数|備考|
|:--|:--|:--|:--|:--|:--|:--|
|決済種別|payType|〇|String|1|50||
|取引ID|accessId|〇|String|24|24||
|オーダーID|id|〇|String|1|30||
|3DS認証結果|paRes||String|1|27|3DS1.0 のみ使用 ( 設定値はURLエンコードが必要です )|

- 引数一覧

|引数|説明|
|:--|:--|
|id|FincodePaymentSecureRequestのidと同値|
|request|リクエスト パラメータ|
|header|リクエスト ヘッダー|
|complete|API実行結果を処理するクロージャー|

---

- カード_一覧取得 - 例

```
let header = ["Content-Type":"application/json", "Authorization":"Bearer p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample"]
 
// 引数の詳細は一覧をご参照ください
FincodeCardOperateRepository.sharedInstance.cardInfoList("c_HSZkCAxNS2q_7TbLcO9y1A", header: header) { result in
    switch result {
    case .success(let data):
          // 正常
    case .failure(let error):
          // 異常
    }
}
```

- 引数一覧

|引数|説明|
|:--|:--|
|customerId|顧客ID|
|header|リクエスト ヘッダー|
|complete|API実行結果を処理するクロージャー|

---

- カード_登録 - 例

```
let header = ["Content-Type":"application/json", "Authorization":"Bearer p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample"]

// プロパティの詳細は一覧をご参照ください 
let request = FincodeCardRegisterRequest()

// 引数の詳細は一覧をご参照ください
FincodeCardOperateRepository.sharedInstance.registerCard("c_HSZkCAxNS2q_7TbLcO9y1A", request: request, header: header) { result in
    switch result {
    case .success(let data):
        // 正常
    case .failure(let error):
        // 異常
    }
}
```

- FincodeCardRegisterRequestプロパティ一覧

|項目名|プロパティ名|必須|型|最小桁数|最大桁数|備考|
|:--|:--|:--|:--|:--|:--|:--|
|デフォルトフラグ|defaultFlag|〇|String|1|1|1：ON　0：OFF|
|カード番号|cardNo|△|String|10|16|トークンに入力がある場合は無視、なしの場合は必須。|
|有効期限|expire|△|String|4|4|トークンに入力がある場合は無視、なしの場合は必須。( YYMM形式 )|
|カード名義人|holderName||String|1|50|トークンに入力がある場合は無視。|
|セキュリティコード|securityCode||String|3|4|トークンに入力がある場合は無視。|
|トークン|token||String|1|512||

- 引数一覧

|引数|説明|
|:--|:--|
|customerId|顧客ID|
|request|リクエスト パラメータ|
|header|リクエスト ヘッダー|
|complete|API実行結果を処理するクロージャー|

---

- カード_更新 - 例

```
let header = ["Content-Type":"application/json", "Authorization":"Bearer p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample"]

// プロパティの詳細は一覧をご参照ください
let request = FincodeCardUpdateRequest()

// 引数の詳細は一覧をご参照ください
FincodeCardOperateRepository.sharedInstance.updateCard("c_HSZkCAxNS2q_7TbLcO9y1A", cardId: "cs_UrDeMDBlQfShg9QZsMPLE", request: request, header: header) { result in
    switch result {
    case .success(let data):
         // 正常
    case .failure(let error):
         // 異常
    }
}
```

- FincodeCardUpdateRequestプロパティ一覧

|項目名|プロパティ名|必須|型|最小桁数|最大桁数|備考|
|:--|:--|:--|:--|:--|:--|:--|
|デフォルトフラグ|defaultFlag|〇|String|1|1|パラメータありの場合のみ更新。  1：ON　（0：OFFは設定不可）|
|有効期限|expire|△|String|4|4|トークンに入力がある場合は無視。  パラメータありの場合のみ更新。 ( YYMM形式 )|
|カード名義人|holderName||String|1|50|トークンに入力がある場合は無視。  パラメータありの場合のみ更新。|
|セキュリティコード|securityCode||String|3|4|トークンに入力がある場合は無視。|
|トークン|token||String|1|512||

- 引数一覧

|引数|説明|
|:--|:--|
|customerId|顧客ID|
|cardId|カードID|
|request|リクエスト パラメータ|
|header|リクエスト ヘッダー|
|complete|API実行結果を処理するクロージャー|

## Licenses

- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON/blob/master/LICENSE)
- [Alamofire](https://github.com/Alamofire/Alamofire/blob/master/LICENSE)
