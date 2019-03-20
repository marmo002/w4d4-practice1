gem "activerecord", "=4.2.10"
require "active_record"
require "mini_record"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact < ActiveRecord::Base

  field :first_name, as: :string
  field :last_name, as: :string
  field :email, as: :string
  field :note, as: :text

  def self.search_me(search_term)
    results = []
    results << self.where("first_name LIKE ?", "%#{search_term}%")
    results << self.where("last_name LIKE ?", "%#{search_term}%")

    results.flatten
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def notes?
    if note.split.count < 1
      "no notes"
    else
      note
    end
  end

end

Contact.auto_upgrade!


# contact1 = Contact.create('Betty', 'Maker', 'bettymakes@gmail.com', 'Loves Pokemon')
# contact2 = Contact.create('Alfonso', 'Rubel', 'alnfonso@mail.com', 'cooks a lot')
# contact3 = Contact.create('Mauricio', 'Nadal', 'nadal@mail.com', 'plays soccer')
# contact4 = Contact.create('Meliza', 'Pineda', 'meliza@mail.com', 'cleans a lot')
