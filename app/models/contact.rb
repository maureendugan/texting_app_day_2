class Contact < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :phone_number, presence: true, numericality: true
  validates_length_of :phone_number, minimum: 10, maximum: 10

  def format_phone
    '(' + self.phone_number[0..2] + ') ' + self.phone_number[3..5] + '-' + self.phone_number[6..9]
  end
end
