# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ActiveRecord::Base.connection.execute('TRUNCATE TABLE posts CASCADE;')
ActiveRecord::Base.connection.execute("SELECT SETVAL ('posts_id_seq', 1, false);")
ActiveRecord::Base.connection.execute("SELECT SETVAL ('post_publishes_id_seq', 1, false);")


10.times do |i|
  post = Post.create(title: "title#{i}", author: "author#{i}")
  post.publish_at!
end