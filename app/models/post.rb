class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many_attached :images
  validates :title, presence: true
  validates :text, presence: true,length:{maximum:200}
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
    def self.search(search) #self.はUser.を意味する
      if search
         where(['text LIKE ?', "%#{search}%"]) #検索とuseanameの部分一致を表示。
      else
         all #全て表示させる
      end
    end
    
    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end
end
