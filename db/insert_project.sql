INSERT INTO project
        (`project_name`, `project_type_id`, `project_team_id`, `date_proposed`, `grade`, `project_description`) 
VALUES 
        (?, 
        ?, 
        ?, 
        STR_TO_DATE(?, '%m-%d-%Y'), 
        ?,
        ?);
