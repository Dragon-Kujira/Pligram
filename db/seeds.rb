# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザーのデータを作成
User.create!(
  email: 'sample1@example.com',
  password: 'sample1',
  name: "ユーザー"
  )

 # 管理者のデータを作成
Admin.create!(
  email: 'admin1@example.com',
  password: 'admin1',
  name: "管理者"
  )

# ジャンルのデータを作成
genres = Genre.create([
  { name: 'アニメ' },
  { name: 'ドラマ' },
  { name: '映画' },
  { name: 'ゲーム' },
  { name: '漫画' },
  { name: '小説' },
])
