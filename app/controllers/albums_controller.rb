class AlbumsController < ApplicationController
  def index
    @album = Album.new
    @albums_pg = Album.page(params[:page]).reverse_order.per(8)
    @user_albums_pg = current_user.albums.page(params[:page]).reverse_order.per(4)
    @user_no_posts = Post.where(album_id: current_user.albums.first.id)
  end

  def show
    @thealbum = find_album(params[:id])

  end

  def edit
    @thealbum = find_album(params[:id])
    @user_posts = current_user.posts
  end

  def create
    album = Album.new(album_params)
    album.user_id = current_user.id
    if album.rate.nil?
      album.rate = 0
    end
    if album.save!
      redirect_to album
    end
  end

  def update
    thealbum = find_album(params[:id])

    if thealbum.update!(
        genre_id: params[:album][:genre_id],
        image: params[:album][:image],
        title: params[:album][:title],
        comment: params[:album][:comment],
        post_quantity: post_quantity_update(thealbum),
        rate: rate_update(thealbum)
      )
        # album更新時に選択した投稿のalbum_id情報を更新
        if thealbum.post_quantity.present?
          c = 0
          while c < thealbum.post_quantity do
            post_id = params[:album][:post_quantity][c].to_i
            post = find_post(post_id)
            # album_id が nil になって、エラーが発生している。
            post.update!(album_id: thealbum.id)
            (c += 1)
          end
        end
      redirect_to thealbum
    end
  end

  def post_quantity_update(album)
    if params[:album][:post_quantity]
      params[:album][:post_quantity].count
    else
      album.post_quantity
    end
  end
  def rate_update(album)
    if params[:album][:rate].nil?
      # 評価をゼロに更新したい可能性は一時的に無視
      album.rate.to_i
    else
      params[:album][:rate].to_i
    end
  end

  def destroy
    thealbum = find_album(params[:id])
    posts = Post.where(album_id: thealbum.id)
    if thealbum.destroy!
      # 削除対象のアルバムに紐づいていた投稿のアルバムIDを未決アルバムのIDに変更
      posts.each do |post|
        post.update!(album_id: current_user.albums.first.id)
      end
      redirect_to albums_path
    end
  end

  private
  def album_params
    params.require(:album).permit(:user_id, :genre_id, :title, :image, :post_quantity, :comment, :rate)
  end
  def post_params
    params.require(:post).permit(:album_id)
  end

  def find_album(album_id)
    Album.find(album_id)
  end
  def find_post(post_id)
    Post.find(post_id)
  end
end
