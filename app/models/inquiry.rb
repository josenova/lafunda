class Inquiry < ActiveRecord::Base

  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :subject, presence: true
  validates :message, presence: true



end
