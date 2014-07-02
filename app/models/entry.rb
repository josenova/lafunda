class Entry < ActiveRecord::Base

  belongs_to :inquiry

  validates :author, presence: true
  validates :message, presence: true

end
