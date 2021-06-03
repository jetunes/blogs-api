json.array! @posts do |this|
    json.id 			this.id
    json.published		this.published
    json.updated 		this.updated_at
    json.title 			this.title
    json.content 		this.content
    json.user do |user|
      json.id 			this.user.id
      json.displayName 	this.user.displayName
      json.email 		this.user.email
      json.image 		this.user.image
    end
end