# == Schema Information
#
# Table name: dim_contacts
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_dim_contacts_on_name  (name) UNIQUE
#

class DimContact < ApplicationRecord
  validates :name, uniqueness: true, presence: true


  def self.import(file)
    CsvDb.importer(file, DimContact, :dim_contact_id, :name )
  end
end
