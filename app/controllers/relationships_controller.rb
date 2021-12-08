class RelationshipsController < ApplicationController
  def create
    # userに代入　params[:followed_id]のデータをUserテーブルから取得
    user = User.find(params[:followed_id])
    # current_userでuserをフォローする
    current_user.follow(user)
    redirect_back(fallback_location:root_path)
  end

  def destroy
    # userに代入　Relationshipテーブルからfollowedカラムの内容がparams[:id]のデータを取得
    user = Relationship.find(params[:id]).followed
    # current_userでuserをアンフォローする
    current_user.unfollow(user)
    redirect_back(fallback_location:root_path)
  end
end
