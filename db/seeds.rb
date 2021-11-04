# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.connection.execute("TRUNCATE TABLE users RESTART IDENTITY CASCADE")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE genres RESTART IDENTITY CASCADE")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE reports RESTART IDENTITY CASCADE")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE report_items RESTART IDENTITY CASCADE")
# ActiveRecord::Base.connection.execute("TRUNCATE TABLE plan_reviews RESTART IDENTITY CASCADE")

user1 = User.create!(email: "satou@example.com", password: "password")
user2 = User.create!(email: "suzuki@example.com", password: "password")
user3 = User.create!(email: "tanaka@example.com", password: "password")

genre1_1 = Genre.create!(name: "Rails", user_id: user1.id)
genre1_2 = Genre.create!(name: "英語", user_id: user1.id)
genre1_3 = Genre.create!(name: "Vue", user_id: user1.id)

genre2_1 = Genre.create!(name: "基本情報", user_id: user2.id)
genre2_2 = Genre.create!(name: "中国語", user_id: user2.id)
genre2_3 = Genre.create!(name: "フロントエンド", user_id: user2.id)

genre3_1 = Genre.create!(name: "食事", user_id: user3.id)
genre3_2 = Genre.create!(name: "会話", user_id: user3.id)
genre3_3 = Genre.create!(name: "プログラミング", user_id: user3.id)

report1 = Report.create!(content: "忙しかったけど学習できた。", user_id: user2.id, reported_on: Date.new(2021, 9, 21))
report2 = Report.create!(content: "こんにちは", user_id: user3.id, reported_on: Date.new(2021, 9, 21))
report3 = Report.create!(content: "こんばんは", user_id: user3.id, reported_on: Date.new(2021, 9, 22))

report_item1_1 = ReportItem.create!(genre_id: genre2_1.id, report_id: report1.id, content: "DB設計", work_hours: 4.5)
report_item1_2 = ReportItem.create!(genre_id: genre2_2.id, report_id: report1.id, content: "コントローラー作成", work_hours: 2.5)
report_item2_1 = ReportItem.create!(genre_id: genre3_1.id, report_id: report2.id, content: "TOEIC学習", work_hours: 1.5)
report_item3_1 = ReportItem.create!(genre_id: genre3_3.id, report_id: report3.id, content: "算出プロパティ学習", work_hours: 3)

plan1 = Plan.create!(user_id: user1.id, genre_id: genre1_1.id, name: "Controllerの作成", set_on: Date.new(2021, 9, 20), deadline: Date.today + 1,
                     status: "進行中")
plan2 = Plan.create!(user_id: user1.id, genre_id: genre1_2.id, name: "TOEIC", set_on: Date.new(2021, 9, 20), deadline: Date.today + 1, status:"進行中")
plan3 = Plan.create!(user_id: user1.id, genre_id: genre1_3.id, name: "レンダリング", set_on: Date.new(2021, 9, 20), deadline: Date.today + 1, status:"進行中")
plan4 = Plan.create!(user_id: user1.id, genre_id: genre1_1.id, name: "MVC学習", set_on: Date.new(2021, 9, 20), deadline: Date.today + 1, status:"進行中")

review1 = Review.create!(user_id: user1.id, reviewed_on: Date.new(2021, 9, 21), content: "よくできた")
review2 = Review.create!(user_id: user1.id, reviewed_on: Date.new(2021, 9, 22), content: "よくなかった")
review3 = Review.create!(user_id: user1.id, reviewed_on: Date.new(2021, 9, 23), content: "いいかんじ")
review4 = Review.create!(user_id: user1.id, reviewed_on: Date.new(2021, 9, 25), content: "テスト")

# review_item1 = plan1.review_items.create!(review_id: review1.id)

# review1.plan_reviews.create!(plan_id:plan1.id)
# review2.plan_reviews.create!(plan_id:plan2.id)
# review3.plan_reviews.create!(plan_id:plan3.id)
# review4.plan_reviews.create!(plan_id:plan4.id)

# plan1.plan_reviews.create!(review_id: review1.id)
# $rails c　で以下を実行
# user1,user2,user3 = User.all
# genre1_1, genre1_2, genre1_3 ,genre2_1, genre2_2, genre2_3 ,genre3_1, genre3_2, genre3_3 = Genre.all
# plan1,plan2,plan3,plan4 = Plan.all
# review1,review2,review3,review4 = Review.all

# □□□□ 日報の作成 □□□□
# report1, report2, report3 = Report.all
# report_item1_1, report_item1_2, report_item2_1, report_item3_1 = ReportItem.all
# user1.reports[0]
#  -> nil　なにも入ってない
# user2.reports[0]
#  -> あり
# user3.reports[0].report_items[0]
#  -> TOEICの学習...
# user3.reports[1].report_items[0]
# -> 算出プロパティの学習....
# user2.reports[0].report_items
# => レポートがいっぱい出てくる  ok

# □□□□ 計画の作成 □□□□
puts "初期データの投入に成功しました！"
