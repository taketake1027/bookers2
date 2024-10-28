class Book < ApplicationRecord
  belongs_to :user
  # has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 } # 最大200文字の制限を追加

  # def image_url
  #   Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
  # end
end
