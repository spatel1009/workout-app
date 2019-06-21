class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :exercises

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  self.per_page = 10

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search_by_name(name)
    names_array = name.split(' ')

    if names_array.size == 1
      where('first_name ILIKE ? or last_name ILIKE ?',
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where('first_name ILIKE ? or first_name ILIKE ? or last_name ILIKE ? or last_name ILIKE ?', "%#{names_array[0]}%",
        "%#{names_array[1]}%", "%#{names_array[0]}%",
        "%#{names_array[1]}%").order(:first_name)
    end
  end
end
