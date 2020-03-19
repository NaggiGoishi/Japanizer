# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)      not null
#  image      :string(255)
#  rate       :float(24)        default("0"), not null
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer
#  city_id    :integer          not null
#  genre_id   :integer          not null
#  user_id    :integer          not null
#
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :city
  belongs_to :genre
  belongs_to :album
  has_many :likes
  has_many :post_comments
end
