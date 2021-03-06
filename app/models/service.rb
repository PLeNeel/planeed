class Service < ApplicationRecord
  has_many :users
  has_many :missions, dependent: :destroy
  has_many :bookings, through: :missions
  has_many :toxics, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  validates :name, :phone_number, :predominant_disease, :typical_workday, :predominant_drugs, presence: true
  after_create :create_chatroom


  def create_chatroom
    Chatroom.create(service: self, name: self.name)
  end
end
