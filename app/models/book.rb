class Book < ApplicationRecord
	belongs_to :user

	has_many :favorites, dependent: :destroy
	has_many :post_comments, dependent: :destroy
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	#ソート用のスコープ
	scope :latest, -> {order(created_at: :desc)}
	scope :highrate, -> {order(grade_evalution: :desc)}
end
