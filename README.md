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

FincodeSDKは、iOS SDK 14以降/Swift4以降が必要です。

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
        config.tds2RetUrl   =   "https://pt01.mul-pay.jp/st/payment/test/postReceiver.jsp"
        config.tds2ChAccChange  =   "20221001"
        config.tds2ChAccDate    =   "20200501"
        config.tds2ChAccPwChange    =   "20210101"
        config.tds2NbPurchaseAccount    =   "5"
        config.tds2PaymentAccAge    =   "20200503"
        config.tds2ProvisionAttemptsDay =   "2"
        config.tds2ShipAddressUsage =   "20200512"
        config.tds2ShipNameInd  =   "01"
        config.tds2SuspiciousAccActivity    =   "02"
        config.tds2TxnActivityDay   =   "3"
        config.tds2TxnActivityYear  =   "30"
        config.tds2ThreeDsReqAuthData   =   "login-tds2-auth-data"
        config.tds2ThreeDsReqAuthMethod =   "03"
        config.tds2ThreeDsReqAuthTimestamp  =   "202110031213"
        config.tds2AddrMatch    =   "Y"
        config.tds2BillAddrCity =   "札幌"
        config.tds2BillAddrCountry  =   "392"
        config.tds2BillAddrLine1    =   "中央区"
        config.tds2BillAddrLine2    =   "北10"
        config.tds2BillAddrLine3    =   "南5"
        config.tds2BillAddrPostCode =   "0650001"
        config.tds2BillAddrState    =   "北海道"
        config.tds2Email    =    "test@tt.com"
        config.tds2HomePhoneCc  =   "+82"
        config.tds2HomePhoneNo  =   "0112223333"
        config.tds2MobilePhoneCc    =   "+84"
        config.tds2MobilePhoneNo    =   "5033337777"
        config.tds2WorkPhoneCc  =   "+86"
        config.tds2WorkPhoneNo  =   "012088887777"
        config.tds2ShipAddrCity =   "港区"
        config.tds2ShipAddrCountry  =   "356"
        config.tds2ShipAddrLine1    =   "東20"
        config.tds2ShipAddrLine2    =   "西30"
        config.tds2ShipAddrLine3    =   "3丁目"
        config.tds2ShipAddrPostCode =   "0016789"
        config.tds2ShipAddrState    =   "東京"
        config.tds2DeliveryEmailAddress =    "sample@ss.com"
        config.tds2DeliveryTimeframe    =   "04"
        config.tds2GiftCardAmount   =   "5560"
        config.tds2GiftCardCount    =   "37"
        config.tds2GiftCardCurr =   "392"
        config.tds2PreOrderDate =   "20221125"
        config.tds2PreOrderPurchaseInd  =   "02"
        config.tds2ReorderItemsInd  =   "01"
        config.tds2ShipInd  =   "07"
        config.tds2RecurringExpiry  =   "20221115"
        config.tds2RecurringFrequency   =   "100"
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

|3DS2.0有無|Class|説明|
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
|3DS2.0認証実行|FincodePaymentRepository|func authentication(_ id: String, request: FincodeAuthRequest, header: [String: String], complete: @escaping (_ result: FincodeApiResult<FincodeAuthResponse>) -> Void)|
|3DS2.0認証結果取得|FincodePaymentRepository|func getResult(_ id: String, header: [String: String], complete: @escaping (_ result: FincodeApiResult<FincodeGetResultResponse>) -> Void)|
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
|決済種別|payType|〇|String|1|50| |
|取引ID|accessId|〇|String|24|24| |
|オーダーID|id|〇|String|1|30| |
|トークン|token|△|String|1|512|カード番号入力方式：トークン方式の場合 必須|
|カード番号|cardNo|△|String|10|16|カード番号入力方式：直接方式の場合 必須|
|有効期限|expire|△|String|4|4|カード番号入力方式：直接方式の場合 必須|
|顧客ID|customerId|△|String|1|60|カード番号入力方式：顧客ID方式の場合 必須|
|カードID|cardId|△|String|25|25|カード番号入力方式：顧客ID方式の場合 必須|
|支払方法|method| |String|1|1|1：一括  2：分割|
|支払回数|payTimes| |String|1|2|支払方法にて、分割を指定していた場合  必須|
|セキュリティコード|securityCode| |String|4|4| |
|カード名義人|holderName| |String|1|50|カード番号入力方式：顧客ID方式の場合 は登録時のカード名義人が優先されます|
|加盟店戻りURL|tds2RetUrl| |String|1|256|"ここから、3DS2.0の項目<br>tds_type が 2 ：行う（3DS2.0を利用）の場合のみ入力チェックを行う"|
|3DSリクエスター アカウント最終更新日|tds2ChAccChange| |String|8|8|yyyyMMdd形式|
|3DSリクエスター アカウント開設日|tds2ChAccDate| |String|8|8|yyyyMMdd形式|
|3DSリクエスター アカウントパスワード変更日|tds2ChAccPwChange| |String|8|8|yyyyMMdd形式|
|過去6ヶ月間の購入回数|tds2NbPurchaseAccount| |String|1|4| |
|カード登録日|tds2PaymentAccAge| |String|8|8|yyyyMMdd形式|
|過去24時間のカード追加の試行回数|tds2ProvisionAttemptsDay| |String|1|3| |
|出荷先住所の最初の使用日|tds2ShipAddressUsage| |String|8|8|yyyyMMdd形式|
|カード顧客名と出荷先名の一致/不一致情報|tds2ShipNameInd| |String|2|2|"カード顧客の顧客名と取引に使用される配送先名の一致/不一致を設定<br>01 = カード顧客名と配送先名が一致<br>02 = カード顧客名と配送先名が不一致"|
|アカウントの不審行為情報|tds2SuspiciousAccActivity| |String|2|2|"カード顧客で、不審な行動（過去の不正行為を含む）を加盟店様が発見したかどうかを設定<br>01 = 不審な行動は見られなかった<br>02 = 不審な行動が見られた"|
|過去24時間の取引回数|tds2TxnActivityDay| |String|1|3| |
|前年の取引回数|tds2TxnActivityYear| |String|1|3| |
|ログイン証跡|tds2ThreeDsReqAuthData|△|String|1|2048|"ログイン証跡を設定した場合<br><br>ログイン方法/ログイン日時の設定が必要"|
|ログイン方法|tds2ThreeDsReqAuthMethod|△|String|2|2|"ログイン方法を設定した場合<br><br>ログイン証跡/ログイン日時の設定が必要<br><br>01 = 認証なし（ゲストとしてログイン）<br>02 = 加盟店様自身の認証情報<br>03 = SSO(シングルサインオン)<br>04 = イシュアーの認証情報<br>05 = サードパーティ認証<br>06 = FIDO認証"|
|ログイン日時|tds2ThreeDsReqAuthTimestamp|△|String|12|12|"ログイン日時を設定した場合<br>ログイン証跡/ログイン方法の設定が必要<br><br>YYYYMMDDHHMM形式"|
|請求先住所と配送先住所の一致/不一致情報|tds2AddrMatch| |String|1|1|"カード顧客の配送先住所とカード顧客の請求先住所の一致/不一致の設定が必要<br>Y=一致<br>N=不一致"|
|カード顧客の請求先住所の都市|tds2BillAddrCity| |String|1|50| |
|カード顧客の請求先住所の国コード|tds2BillAddrCountry| |String|1|3| |
|カード顧客の請求先住所の区域部分の１行目|tds2BillAddrLine1| |String|1|50| |
|カード顧客の請求先住所の区域部分の２行目|tds2BillAddrLine2| |String|1|50| |
|カード顧客の請求先住所の区域部分の３行目|tds2BillAddrLine3| |String|1|50| |
|カード顧客の請求先住所の郵便番号|tds2BillAddrPostCode| |String|1|16| |
|カード顧客の請求先住所の州または都道府県コード|tds2BillAddrState| |String|1|3| |
|カード顧客のメールアドレス|tds2Email| |String|1|254| |
|自宅電話の国コード|tds2HomePhoneCc|△|String|1|3|"自宅電話の国コードを設定した場合<br>自宅電話番号の設定が必要"|
|自宅電話番号|tds2HomePhoneNo|△|String|1|15|"自宅電話番号を設定した場合<br><br>自宅電話の国コードの設定が必要<br><br>ハイフン（-）なし、数字のみ"|
|携帯電話の国コード|tds2MobilePhoneCc|△|String|1|3|"携帯電話の国コードを設定した場合<br><br>携帯電話番号の設定が必要"|
|携帯電話番号|tds2MobilePhoneNo|△|String|1|15|"携帯電話番号の国コードを設定した場合<br><br>携帯電話の国コードの設定が必要<br><br>ハイフン（-）なし、数字のみ"|
|職場電話の国コード|tds2WorkPhoneCc|△|String|1|3|"職場電話の国コードを設定した場合<br><br>職場電話番号の設定が必要"|
|職場電話番号|tds2WorkPhoneNo|△|String|1|15|"職場電話番号を設定した場合<br><br>職場電話の国コードの設定が必要<br><br>ハイフン（-）なし、数字のみ"|
|出荷先住所の都市|tds2ShipAddrCity| |String|1|50| |
|出荷先住所の国コード|tds2ShipAddrCountry| |String|1|3| |
|出荷先住所の区域部分の１行目|tds2ShipAddrLine1| |String|1|50| |
|出荷先住所の区域部分の２行目|tds2ShipAddrLine2| |String|1|50| |
|出荷先住所の区域部分の３行目|tds2ShipAddrLine3| |String|1|50| |
|出荷先住所の郵便番号|tds2ShipAddrPostCode| |String|1|16| |
|出荷先住所の州または都道府県コード|tds2ShipAddrState| |String|1|3| |
|納品先電子メールアドレス|tds2DeliveryEmailAddress| |String|1|254| |
|商品納品時間枠|tds2DeliveryTimeframe| |String|2|2|"01 = 電子デリバリー<br>02 = 当日出荷<br>03 = 翌日出荷<br>04 = 2日目以降の出荷"|
|プリペイドカードまたはギフトカードの総購入金額|tds2GiftCardAmount| |String|1|15| |
|購入されたプリペイドカードまたはギフトカード / コードの総数|tds2GiftCardCount| |String|2|2|0埋め2桁の数字|
|通貨コード|tds2GiftCardCurr| |String|3|3|"※以下のコードは対象外<br>955, 956, 957, 958, 959, 960, 961, 962,<br>963, 964, 999"|
|商品の発売予定日|tds2PreOrderDate| |String|8|8|YYYYMMDD形式|
|商品の販売時期情報|tds2PreOrderPurchaseInd| |String|2|2|"01 = 発売済み商品<br>02 = 先行予約商品"|
|商品の注文情報|tds2ReorderItemsInd| |String|2|2|"01 = 初回注文<br>02 = 再注文"|
|取引の出荷方法|tds2ShipInd| |String|2|2|"01 = カード顧客の請求先住所に配送する<br>02 = 加盟店様が保持している別の、確認済み住所に配送する<br>03 = カード顧客の請求先住所と異なる住所に配送する<br>04 = 店舗へ配送 / 近所の店舗での受け取り（店舗の住所は配送先住所で指定する）<br>05 = デジタル商品（オンラインサービス、電子ギフトカードおよび償還コードを含む）<br>06 = 配送なし（旅行およびイベントのチケット）<br>07 = その他（ゲーム、配送されないデジタルサービス、電子メディアの購読料など）"|
|継続課金の期限|tds2RecurringExpiry| |String|8|8|YYYYMMDD形式|
|継続課金の課金最小間隔日数|tds2RecurringFrequency| |String|1|4| |


- 引数一覧

|引数|説明|
|:--|:--|
|id|FincodePaymentRequestのidと同値|
|request|リクエスト パラメータ|
|header|リクエスト ヘッダー|
|complete|API実行結果を処理するクロージャー|

---

- 3DS2.0認証実行 - 例

```
let header = ["Content-Type":"application/json", "Authorization":"Bearer p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample"]

// プロパティの詳細は一覧をご参照ください
let request = FincodeAuthRequest()

// 引数の詳細は一覧をご参照ください
FincodePaymentRepository.sharedInstance.authentication("o_XqXw_hhlQAa7FFzCSample", request: request, header: header) { result in
    switch result {
    case .success(let data):         
    // 正常    
    case .failure(let error):         
    // 異常
    }
}
```

- FincodeAuthRequestプロパティ一覧

|項目名|プロパティ名|必須|型|最小桁数|最大桁数|備考|
|:--|:--|:--|:--|:--|:--|:--|
|取引ID|id|〇|String|24|24| |
|ブラウザ情報|param|〇|String|1|2000|認証APIにて必要となるブラウザ情報<br>(browserInfo)が送られてきている |

- 引数一覧

|引数|説明|
|:--|:--|
|id|FincodeAuthRequestのidと同値|
|request|リクエスト パラメータ|
|header|リクエスト ヘッダー|
|complete|API実行結果を処理するクロージャー|

---

- 3DS2.0認証結果取得 - 例

```
let header = ["Content-Type":"application/json", "Authorization":"Bearer p_prod_ZTlkN2JkMzctZDY4Ni00ZDE4LTSample"]

// プロパティの詳細は一覧をご参照ください
let request = FincodeGetResultRequest()

// 引数の詳細は一覧をご参照ください
FincodePaymentRepository.sharedInstance.getResult("o_XqXw_hhlQAa7FFzCSample", request: request, header: header) { result in
    switch result {
    case .success(let data):         
    // 正常    
    case .failure(let error):         
    // 異常
    }
}
```

- FincodeGetResultRequestプロパティ一覧

|項目名|プロパティ名|必須|型|最小桁数|最大桁数|備考|
|:--|:--|:--|:--|:--|:--|:--|
|取引ID|id|〇|String|24|24| |

- 引数一覧

|引数|説明|
|:--|:--|
|id|FincodeGetResultRequestのidと同値|
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
|決済種別|payType|〇|String|1|50| |
|取引ID|accessId|〇|String|24|24| |
|オーダーID|id|〇|String|1|30| |
|3DS認証結果|paRes| |String|1|27|3DS1.0 のみ使用 ( 設定値はURLエンコードが必要です )|

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
|カード名義人|holderName| |String|1|50|トークンに入力がある場合は無視。|
|セキュリティコード|securityCode| |String|3|4|トークンに入力がある場合は無視。|
|トークン|token| |String|1|512| |

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
|カード名義人|holderName| |String|1|50|トークンに入力がある場合は無視。  パラメータありの場合のみ更新。|
|セキュリティコード|securityCode| |String|3|4|トークンに入力がある場合は無視。|
|トークン|token| |String|1|512| |

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
