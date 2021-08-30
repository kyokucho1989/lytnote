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
ActiveRecord::Base.connection.execute("TRUNCATE TABLE plan_reviews RESTART IDENTITY CASCADE")

user1 = User.create!(email: "satou@example.com", password: "password")
user2 = User.create!(email: "suzuki@example.com", password: "password")
user3 = User.create!(email: "tanaka@example.com", password: "password")

genre1 = Genre.create!(name: "Rails")
genre2 = Genre.create!(name: "英語")
genre3 = Genre.create!(name: "Vue")

report1 = Report.create!(content: "忙しかったけど学習できた。", user_id: user2.id)
report2 = Report.create!(content: "こんにちは", user_id: user3.id)
report3 = Report.create!(content: "こんばんは", user_id: user3.id)

report_item1_1 = ReportItem.create!(genre_id: genre1.id,report_id:report1.id,content: "DB設計", work_hours: 4.5) 
report_item1_2 = ReportItem.create!(genre_id: genre1.id,report_id:report1.id,content: "コントローラー作成", work_hours: 2.5) 
report_item2_1 = ReportItem.create!(genre_id: genre2.id,report_id:report2.id,content: "TOEIC学習", work_hours: 1.5) 
report_item3_1 = ReportItem.create!(genre_id: genre3.id,report_id:report3.id,content: "算出プロパティ学習", work_hours: 3) 

plan1 = Plan.create!(user_id: user1.id, genre_id: genre1.id, name: "Controllerの作成", deadline:Date.new(2021,9,30))

# $rails c　で以下を実行
# user1,user2,user3 = User.all
# genre1, genre2, genre3 = Genre.all

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