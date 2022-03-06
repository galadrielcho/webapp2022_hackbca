SELECT 
    project_name, 
    team.team_name as project_team,
    project_type_name,
    grade,
    DATE_FORMAT(project.date_proposed, '%m-%d-%Y') as date_proposed,
    project_description

FROM 
	project, project_type, team
WHERE
	project.project_id = ?
    and project_team_id = team_id
LIMIT 1