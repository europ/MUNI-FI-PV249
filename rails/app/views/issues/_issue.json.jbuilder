json.extract! issue, :id, :subject, :text, :repository_id, :created_at, :updated_at
json.url issue_url(issue, format: :json)
