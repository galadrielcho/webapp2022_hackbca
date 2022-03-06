SELECT 
	project.project_id as project_id, 
    project.project_name, 
    team.team_name,
    project_type.project_type_name,
    grade,
    DATE_FORMAT(project.date_proposed, '%m/%d/%Y') as date_proposed,
    project_likes
FROM 
	project LEFT JOIN (
		SELECT COUNT(*) as project_likes, like_project_id 
        FROM project_like
		GROUP BY like_project_id
	) as total_likes ON project.project_id = total_likes.like_project_id,
    project_type,
    team
WHERE
	project.project_type_id = project_type.project_type_id
    and project.project_team_id = team.team_id
GROUP BY project_id