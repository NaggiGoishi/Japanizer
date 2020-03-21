# == Schema Information
#
# Table name: albums
#
#  id            :bigint           not null, primary key
#  comment       :text(65535)
#  image         :string(255)
#  post_quantity :integer          not null
#  rate          :float(24)        default("0")
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  genre_id      :integer          not null
#  plan_id       :integer          not null
#  user_id       :integer          not null
#
require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
