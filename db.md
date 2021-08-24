# 必要なデータ(場面から考える)

## ログイン時

### 通常ユーザー
- ログインID(メールアドレス)
- ユーザー名
- ログインPass

### 管理者
- 管理者ID
- 管理者用Pass


## 日報を書く時
- 日付
- ジャンル
- やったこと
- 工数
↑ max 3つ
- コメント

## 目標設定（毎週）
- 計画名
- 締め切り
↑ max 3つ

## 振り返り(毎週)
- 設定した目標の閲覧
- 達成できたか
- 振り返りのコメント


## ER図

![](https://i.imgur.com/uVqaVKW.png)


### User
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|login_id   |string  |null:false    |ログインID   |
|user_name  |string  |null:false    |名前   |
|password  |string  |null:false   |パスワード   |

- has many: User_Daily_Comment
- has many: User_Review_Comment
- has many: User_Plan_List

### User_Daily_Comment
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|user_id    |integer  |null:false |-   |
|created_commnent_at |datetime |null:false |登録日   |
|daily_comment   |string  |null:false    |コメント   |

- has many: Done_List
- belongs_to :User

- 1日1個しか投稿できない


### Done_List
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|daily_comment_id   |integer  |null:false    |-   |
|type_id   |integer  |null:false    |種類   |
|name   |string  |null:false    |やったことの内容   |
|work_hours   |float  |null:false    |作業時間   |

- belongs_to :user_daily_comment
- belongs_to :type

### User_Review_comment
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|user_id    |integer  |null:false |-   |
|created_review_at |datetime |null:false |登録日   |
|review_comment   |string  |null:false    |振り返りコメント   |

- belongs_to :User
- has_many :plan_review_list

- 1週間に1個しか投稿できない

### Plan_List
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|user_id    |integer  |null:false |-   |
|plan_name   |string  |null:false    |計画の名前   |
|type_id   |integer  |null:false    |種類   |
|created_at |datetime |null:false |登録日   |
|update_at |datetime |null:false |更新日   |
|deadline |datetime |null:false |締め切り   |
|status_id |integer |null:false |進行中/完了/取りやめ  |

- belongs_to :User
- belongs_to :type
- belongs_to :status
- has_many :plan_review_list

### Plan_Review_List
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|plan_id   |integer  |null:false    |計画のid  |
|review_id   |integer  |null:false    |振り返りのid  |
- belongs_to :plan_list
- belongs_to :user_review_comment


### Type
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|name   |string  |null:false    |計画/やったことの種類   |

- has_many done_list
- has_many plan_list

### Status
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|name   |string  |null:false    |Planのステータス　進行中/完了/取りやめ   |

- has_many plan_list

## 入力の例

### 日報登録時

```
日付
 2021/5/3 (User_daily_comment/登録日)
やったこと1
  種類: JS学習 (Done_List/type_id)
  やったことの内容 ：　非同期処理の学習 (Done_List/name)
  作業時間:1h(Done_List/work_hours)

やったこと２
　種類：個人開発
　やったことの内容 ：DB設計
　作業時間:0.5h

コメント(User_Daily_Comment/daily_comment)
　おもったより学習時間がとれなかった。
```


### 計画登録時
　
```
日付
2021/5/2(Plan_List/created_at)
種類：JS教材(Plan_List/type_id )
名前：課題1提出(Plan_List/plan_name)
期日:2021/5/10 (Plan_List/deadline)
```

あとから編集できる

### 振り返りコメント作成
　
```
振り返りの日付
2021/5/2(User_Review_comment/created_at)

今週が締め切りだった計画の表示
(Plan_List)
- JS教材　課題2までやる....   できたかどうか　チェック (Plan_List/status_id)
- 個人開発　DB設計までやる....   できたかどうか　チェック

振り返りコメント：(User_Review_comment/review_comment)
　週の半ばで体調を崩してペースを落とした。後半は巻き返した。


来週の目標設定
....
　（目標は振り返りの時も作成できる。あとからでも追加できる）
```


