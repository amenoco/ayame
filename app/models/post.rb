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
  has_one_attached :profile_image
    def get_profile_image(hight, width)
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/sample-author1.png')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [hight, width]).processed
    end
    
     # 公開・非公開機能
  scope :published, -> {where(is_published_flag: true)}
  scope :unpublished, -> {where(is_published_flag: false)}
end