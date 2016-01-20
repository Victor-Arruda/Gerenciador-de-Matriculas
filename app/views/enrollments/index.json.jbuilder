json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :enrollment_date, :year, :active, :paid, :student_id, :course_id
  json.url enrollment_url(enrollment, format: :json)
end
