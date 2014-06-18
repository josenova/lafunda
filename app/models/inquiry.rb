class Inquiry < ActiveRecord::Base

  belongs_to :user

  validates :subject, presence: true
  validates :message, presence: true



end
