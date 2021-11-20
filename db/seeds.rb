User.create!(id: 1, email: 'yuya.scuba0411@gmail.com', password: '19940411', password_confirmation: '19940411')
User.create!(id: 2, email: 'yuya.kawai@gmail.com', password: '19940411', password_confirmation: '19940411')

Idea.create!(id: 1, title: '有明海', memo: '綺麗ですね', user_id: 1 )
Idea.create!(id: 2, title: '四日市コンビナート', memo: 'かっこいいですね', user_id: 2)