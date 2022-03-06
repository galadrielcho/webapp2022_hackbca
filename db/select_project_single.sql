SELECT 
	project.project_id as project_id, 
    project.project_name, 
    team.team_name,
    project_type.project_type_name,
    grade,
	project_description,
    DATE_FORMAT(project.date_proposed, '%m/%d/%Y') as date_proposed
FROM 
	project,
    project_type,
    team
WHERE
	project.project_type_id = project_type.project_type_id
    and project.project_team_id = team.team_id
	and project.project_id = ?
