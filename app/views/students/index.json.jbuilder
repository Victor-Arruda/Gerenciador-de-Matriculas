json.array!(@students) do |student|
  json.extract! student, :id, :cpf, :rg, :birth_date, :name, :phone
  json.url student_url(student, format: :json)
end
