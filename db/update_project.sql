UPDATE project
SET
	project_name = ?,
    project_type_id = ?,
    project_team_id = ?,
    date_proposed = STR_TO_DATE(?, '%m-%d-%Y'), 
	grade = ?,
    project_description = ?
WHERE
	project_id = ?