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

- has many: User_Daily_comment
- has many: User_Review_comment

### User_Daily_comment
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|user_id    |integer  |null:false |-   |
|created_at |datetime |null:false |登録日   |
|daily_comment   |string  |null:false    |コメント   |

- has many: Done_list
- belongs_to :user

### Done_list
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
|created_at |datetime |null:false |登録日   |
|review_comment   |string  |null:false    |振り返りコメント   |

- has many: Plan_list


### Plan_List
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|plan_name   |string  |null:false    |計画の名前   |
|type_id   |integer  |null:false    |種類   |
|created_at |datetime |null:false |登録日   |
|update_at |datetime |null:false |更新日   |
|deadline |datetime |null:false |締め切り   |
|status_id |integer |null:false |進行中/完了/取りやめ  |

- belongs_to :type
- belongs_to :status

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



