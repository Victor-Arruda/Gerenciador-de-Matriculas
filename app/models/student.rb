class Student < ActiveRecord::Base
  has_many :enrollments
  validates_uniqueness_of :cpf
  validates_presence_of :cpf, :rg, :birth_date, :name, :phone
  validate :check_cpf

  def check_cpf
    require 'cpf_cnpj'
    errors.add(:cpf, 'Esse CPF não é válido!') unless CPF.valid? self.cpf
  end
end
