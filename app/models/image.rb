class Image < ApplicationRecord
  belongs_to :photolink, polymorphic: true

  validates :name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, format: { with: /\Ahttps?:\/\/\S+\z/i }
  validates :photolink_type, presence: true
  validates :photolink_id, presence: true
end
