//This JS provides functions for pseudo-functionality for certain kinds of buttons.
// Switch statements: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch
// setTimeout: https://developer.mozilla.org/en-US/docs/Web/API/setTimeout


function confirmDelete(project_name, redirect_to){
    if(confirm(`Are you sure you want to delete the project ${project_name}? This is PERMANENT and cannot be undone.`)) {
        alert(`Successfully deleted the project ${project_name}.`);
        window.location.href = redirect_to
    }
}

function confirmCommentDelete(comment_id, redirect_to){
    if(confirm(`Are you sure you want to delete this comment (id: ${comment_id})? This is PERMANENT and cannot be undone.`)) {
        alert(`Successfully deleted commment.`);
        window.location.href = redirect_to
    }
}


function selectLike(likeButton, event_id){
    let likeButtonIcon = likeButton.children[0];
    switch(likeButtonIcon.textContent) {
    case "favorite_border": //currently off, toggle on.
        console.log("Toggle On!")
        likeButton.classList.replace("scale-in", "scale-out");
        
        //Send update to server, wait for confirmation before showing on button
        //Simulate waiting with a timeout for now...
        setTimeout(function(){
            likeButtonIcon.textContent = "favorite";
            likeButton.classList.replace("red", "amber");
            likeButton.classList.replace("scale-out", "scale-in");
        }, 500);
        
    break;
    case "favorite": //currently on, toggle off
        console.log("Toggle Off!")
        likeButton.classList.replace("scale-in", "scale-out");

        //Send update to server, wait for confirmation before showing on button
        //Simulate waiting with a timeout for now...
        setTimeout(function(){
            likeButtonIcon.textContent = "favorite_border";
            likeButton.classList.replace("amber", "red");
            likeButton.classList.replace("scale-out", "scale-in");
        }, 500);
    break;
    default: //currently in star_half, processing... don't do anything yet.
    }
    //Until server response comes, show a "processing" symbol - which means clicking does nothing until response comes.
    likeButtonIcon.textContent = "autorenew";
}