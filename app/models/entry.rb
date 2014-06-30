class Entry < ActiveRecord::Base

  belongs_to :inquiry

  validates :author, presence: true
  validates :message, presence: true
  validates :employee, presence: true

end
