class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  #relationshipモデルを指定する。外部キーによって差別化
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  #followed_id用の関連付け。followedsにならない様に名前を変更
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  #ユーザーをフォローする
  def follow(other_user)
    #followingの最後にother_userを追加？
    following << other_user
  end

  #ユーザーをフォロー解除する
  def unfollow(other_user)
    #active_relationshipsからfollowed_idがother_user.idのデータを取得して削除
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    # followingにother_userが含まれているか
    following.include?(other_user)
  end
end
