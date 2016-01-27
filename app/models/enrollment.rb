class Enrollment < ActiveRecord::Base
  before_create :confirm_enrollment, :enrollment_not_paid
  belongs_to :student
  belongs_to :course
  validates_presence_of :student_id, :course_id, :enrollment_date, :year
  validate :can_do_the_enrollment

  CEDULAS = [100, 50, 10, 5, 1]
  MOEDAS = [50, 25, 10, 5, 1]

  def self.search(tipo, valor, status)
    if(tipo.present? or status.present?)
      to_return = all
      if valor.present?
        if tipo == "Ano"
          to_return = all.where(year: valor)
        elsif tipo == "Aluno"
          to_return = all.joins(:student).where("students.name ILIKE '%#{valor}%'")
        elsif tipo == "Curso"
          to_return = all.joins(:course).where("courses.name ILIKE '%#{valor}%'")
        end
      end
      if status.present?
        return to_return.where(paid: 1) if status == "Pago"
        return to_return.where(paid: 2) if status == "Pendente"
        return to_return if status = "Todos"
      end
    else
      all.where(active: 1)
    end
  end

  def melhor_troco(pago)
    valor = self.course.price.to_f
    if pago < valor
      false
    else
      troco = pago - valor
      valor = troco.to_i
      cedulas = []
      centavos = []
      i = 0
      while(valor != 0 )
        ct = (valor / Enrollment.CEDULAS[i]).to_i
        if (ct != 0)
          valor_cedula = Enrollment.CEDULAS[i]
          cedulas << ["#{valor_cedula}" => ct]
          valor = valor % Enrollment.CEDULAS[i]
        end
        i += 1
      end


      valor = ((troco - troco.to_i) * 100).round.to_i
      i = 0
      while(valor != 0)
        ct = valor / Enrollment.MOEDAS[i]
        if (ct != 0 )
          valor_centavo = Enrollment.MOEDAS[i]
          centavos << ["#{valor_centavo}" => ct]
          valor = valor % Enrollment.MOEDAS[i]
        end
        i+=1
      end
      [cedulas, centavos]
    end
  end

  private

  def self.MOEDAS
    MOEDAS
  end

  def self.CEDULAS
    CEDULAS
  end



  def confirm_enrollment
    self.active = 1
  end

  private

  def enrollment_not_paid
    self.paid = 2
  end

  def can_do_the_enrollment
    #code
    student.enrollments.each do |enrollment|
      if enrollment.active == 1
        errors.add(:base, 'Aluno possui matrícula ativa em curso de mesmo período e ano informado!') if ((enrollment.year == self.year and enrollment.course.period == self.course.period) or (enrollment.year == self.year and (enrollment.course.period == 1 or enrollment.course.period == 2) and self.course.period == 3) or (enrollment.year == self.year and enrollment.course.period == 3))
      end
    end
  end
end
