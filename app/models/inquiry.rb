class Inquiry < ActiveRecord::Base

  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :user_id, presence: true
  validates :subject, presence: true, length: { maximum: 38 }
  validates :message, presence: true



end
