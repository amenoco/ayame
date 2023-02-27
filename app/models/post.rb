class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many_attached :images
  has_many :post_comments, dependent: :destroy
  
    def self.search(search) #self.はUser.を意味する
      if search
         where(['text LIKE ?', "%#{search}%"]) #検索とuseanameの部分一致を表示。
      else
         all #全て表示させる
      end
    end
end
