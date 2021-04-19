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


## 構造

```
User
> daily_comment
>> done list

> review_comment


> plan_list

plan_review_list


Type

Status
```



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
|created_at |datetime |null:false |登録日   |
|daily_comment   |string  |null:false    |コメント   |

- has many: Done_List
- belongs_to :User

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
|created_at |datetime |null:false |登録日   |
|review_comment   |string  |null:false    |振り返りコメント   |

- belongs_to :User


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

### Plan_Review_List
|Colum|type     |Options|memo|
|-    |-        |-    |-    |
|id   |integer  |-    |-   |
|plan_id   |integer  |null:false    |計画のid  |
|review_id   |integer  |null:false    |振り返りのid  |


planとreviewを多対多で関連づけ。


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



