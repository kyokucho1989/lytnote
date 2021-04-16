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

# 問題
- 日報を登録する際にやったことは複数、コメントはひとつだけ書きたい。
　DBはどうすればいいか。

- 振り返りのコメントも同じ問題がある。


### User
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|login_id   |string  |null:false    |ログインID   |
|user_name  |string  |null:false    |名前   |
|password  |string  |null:false   |パスワード   |

- has many: user_plan

### User_plan
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|user_id    |integer  |null:false |-   |
|plan_name   |string  |null:false    |計画の名前   |
|type_id   |string  |null:false    |種類   |
|deadline |datetime |null:false |締め切り   |
|is_complete |boolean |null:false |終了したかどうか   |


- belongs_to :user
- has_many :growth_record

### Type
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|name   |string  |null:false    |計画/やったことの種類   |

- has_many user_plan

### User_done_list
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|record_date |datetime |null:false |登録日   |
|type_id   |string  |null:false    |種類   |
|name   |string  |null:false    |やったことの内容   |
|work_hours   |float  |null:false    |作業時間   |

