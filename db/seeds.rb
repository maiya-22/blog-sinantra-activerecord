# require 'faker'


# 5.times do   
#   User.create([{
#                 user_name: Faker::Name.first_name,
#                 password: 'secretpassword',
#                 pic: Faker::Avatar.image('my-own-slug', '50x50'),
#                 bio: Faker::Matz.quote,
#                 birthday: Faker::Date.birthday(18, 65)
#               }])
# end

# id = 1  
# 5.times do
#   Demographic.create([{
#     gender: Faker::Demographic.sex,
#     generation: Faker::Types.character,
#     country: Faker::Address.country,
#     user_id: id
#   }])
#   id += 1
# end

# 2.times do 
#     id = 1
#     5.times do 
#         Blog.create([
#             title: Faker::Book.title ,
#             summary:Faker::Lorem.sentence(5), 
#             user_id: id
#         ])
#         id += 1
#     end
# end

# 20.times do       
#     id = 1
#     10.times do 
#         Post.create([{
#             title: Faker::Lorem.sentence(1),
#             content:Faker::Lorem.sentence(5), 
#             blog_id: id
#         }])
#         id += 1
#     end
#  end

# 3.times do        
#     id = 1
#     200.times do
#         Comment.create([{
#             content: Faker::Lorem.sentence(5),
#             likes: Random.new.rand(10),
#             post_id: id,
#             user_id: Random.new.rand(5) + 1
#         }])
#     id+=1
#     end
# end

# 20.times do       
#     Tag.create([{
#         name: Faker::Hipster.sentence(1, true, 0).downcase.chop
#     }])
# end




# @post_id = 1     
# 200.times do
#     3.times do
#         @random_tag_id = Random.new.rand(20) + 1
#         while(@random_tag_id ==  @last_random_id) do
#             @random_tag_id = Random.new.rand(20) + 1 
#         end
#         Post_tag.create({
#            post_id:  @post_id,
#            tag_id:  @random_tag_id
#        })
#        @last_random_id =  @random_tag_id
#     end
#     @post_id +=1 
#     @last_random_id = 0 
# end
