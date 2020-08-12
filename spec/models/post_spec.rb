# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  comment       :text(65535)      not null
#  rate          :float(24)        not null
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  album_id      :integer          not null
#  city_id       :integer          not null
#  genre_id      :integer          not null
#  image_id      :string(255)
#  prefecture_id :integer          not null
#  user_id       :integer          not null
#
require 'rails_helper'

RSpec.describe 'Post', type: :model do
  describe 'Save' do

    context 'Collectly' do
      before do
        @post = FactoryBot.create(:post)
      end
      # can save with all fill in
      it 'with a comment, rate, title, album_id, city_id, genre_id, pref_id' do
        expect(@post).to be_valid
      end
    end

    context 'Incollectly' do
      # can't save without comment
      it 'without a comment' do
        @post = Post.new(comment: nil)
        expect(@post.valid?).to eq(false)
      end
      # can't save without rate
      it 'without a rate' do
        @post = Post.new(rate: nil)
        expect(@post.valid?).to eq(false)
      end
      # can't save without title
      it 'without a title' do
        @post = Post.new(title: nil)
        expect(@post.valid?).to eq(false)
      end
      # can't save without album_id
      it 'without a album_id' do
        @post = Post.new(album_id: nil)
        expect(@post.valid?).to eq(false)
      end
      # can't save without city_id
      it 'without a city_id' do
        @post = Post.new(city_id: nil)
        expect(@post.valid?).to eq(false)
      end
      # can't save without genre_id
      it 'without a genre_id' do
        @post = Post.new(genre_id: nil)
        expect(@post.valid?).to eq(false)
      end
      # can't save without prefecture_id
      it 'without a prefecture_id' do
        @post = Post.new(prefecture_id: nil)
        expect(@post.valid?).to eq(false)
      end
    end

  end
end
