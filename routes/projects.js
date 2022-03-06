var express = require('express');
var router = express.Router();
var db = require('../db/db');

const fs = require('fs');
const path = require('path');
const { redirect } = require('express/lib/response');


let projectsQuery = fs.readFileSync(path.join(__dirname, "../db/select_projects.sql"), "utf-8");

/* GET events "home" page - a list of all projects. */
router.get('/', async function(req, res, next) {
  try {
    let results = await db.queryPromise(projectsQuery)
    console.log(results);
    res.render('projects', { title: 'Projects', style: "tables", projects: results});
  } catch (err) {
    next(err);
  }
});


let projectsTeamsQuery = fs.readFileSync(path.join(__dirname, "../db/select_project_teams.sql"), "utf-8");

router.get('/create', async function(req, res, next) {
  try {
    let teams = await db.queryPromise(projectsTeamsQuery);

    res.render('projectform', {title: "Create Project",
                                team: teams})
  } catch(err) {
    next(err);
  }
})

let singleProjectQuery = fs.readFileSync(path.join(__dirname, "../db/select_project_single.sql"), "utf-8");
let projectCommentsQuery = fs.readFileSync(path.join(__dirname, "../db/select_project_comments.sql"), "utf-8");


router.get('/:project_id', async function(req, res, next) {
  try {
    let project_id = req.params.project_id
    let comments = await db.queryPromise(projectCommentsQuery, [project_id]);
    let project_data = await db.queryPromise(singleProjectQuery, [project_id]);
    console.log(project_data);
    res.render('project', { title: 'Project Details', 
                      styles: ["tables", "project"], 
                      project_id : project_id, 
                      project_data: project_data[0],
                      comments: comments});
  } catch(err) {
    next(err);
  }

});


let singleProjectFormQuery = fs.readFileSync(path.join(__dirname, "../db/select_project_single_form.sql"), "utf-8");

router.get('/:project_id/modify', async function(req, res, next) {
  try {
    let teams = await db.queryPromise(projectsTeamsQuery);
    let project_id = req.params.project_id
    let results = await db.queryPromise( singleProjectFormQuery, [project_id]);
    let project_data = results[0];
    console.log(project_data);
    res.render('projectform', {title: "Modify Project", 
                                    team: teams,
                                    project: project_data});
  } catch(err) {
    next(err);
  }

});


let insertTeamQuery = fs.readFileSync(path.join(__dirname, "../db/insert_project_team.sql"), "utf-8");
let insertProjectType = fs.readFileSync(path.join(__dirname, "../db/insert_project_type.sql"), "utf-8");
let insertProjectQuery = fs.readFileSync(path.join(__dirname, "../db/insert_project.sql"), "utf-8");
// (`project_name`, `project_type_id`, `project_team_id`, `date_proposed`, `grade`, `project_description`) 

router.post('/',async function(req, res, next) {
  try {
    let team_results = await db.queryPromise(insertTeamQuery, [req.body.project_team])
    let type_results = await db.queryPromise(insertProjectType, [req.body.project_type])
    let results = await db.queryPromise(insertProjectQuery, [req.body.project_name, 
      type_results.insertId, 
      team_results.insertId, 
      `${req.body.project_date}`,
      req.body.grade,
      req.body.project_desc
    ]);

  let project_id_inserted = results.insertId;
  res.redirect(`/projects/${project_id_inserted}`);
  } catch(err) {
    next(err);
  }
})

let updateProjectQuery = fs.readFileSync(path.join(__dirname, "../db/update_project.sql"), "utf-8"); 
router.post('/:project_id' ,async function(req, res, next) {
  console.log("TEST!!")
  try {
    let team_results = await db.queryPromise(insertTeamQuery, [req.body.project_team])
    let type_results = await db.queryPromise(insertProjectType, [req.body.project_type])

    let results = await db.queryPromise(updateProjectQuery, [req.body.project_name, 
      type_results.insertId, 
      team_results.insertId, 
      `${req.body.project_date}`,
      req.body.grade,
      req.body.project_desc
    ]);

    res.redirect(`/projects/${req.params.event_id}`);
    } catch(err) {
      next(err);
    }
})

module.exports = router;
