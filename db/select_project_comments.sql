select
	comment_content,
	comment_id,
	email
from 
	comment, 
    user
where 
	comment_user_id = user.user_id
	and comment_project_id = ?