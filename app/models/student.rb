class Student < ActiveRecord::Base
  has_many :enrollments
  validates_uniqueness_of :cpf
  validates_presence_of :cpf, :rg, :birth_date, :name, :phone
  validate :check_cpf

  def check_cpf
    require 'cpf_cnpj'
    errors.add(:cpf, 'Esse CPF não é válido!') unless CPF.valid? self.cpf
  end

  def bissextile_year
    year = self.birth_date.year
    if(year % 4 == 0 and year % 100 != 0 or year % 400 == 0)
      true
    else
       false
    end
  end
end
