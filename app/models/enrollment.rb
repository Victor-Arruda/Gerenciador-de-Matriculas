class Enrollment < ActiveRecord::Base
  before_create :confirm_enrollment, :enrollment_not_paid
  belongs_to :student
  belongs_to :course
  validates_presence_of :student_id, :course_id, :enrollment_date, :year
  validate :can_do_the_enrollment

  private

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
      errors.add(:base, 'Aluno possui matrícula ativa em curso de mesmo período e ano informado!') if ((enrollment.year == self.year and enrollment.course.period == self.course.period) or (enrollment.year == self.year and (enrollment.course.period == 1 or enrollment.course.period == 2) and self.course.period == 3) or (enrollment.year == self.year and enrollment.course.period == 3))
    end
  end
end
