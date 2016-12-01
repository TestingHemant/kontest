json.extract! problem, :id, :name, :email, :mobile, :report_type, :issue_description, :created_at, :updated_at
json.url problem_url(problem, format: :json)