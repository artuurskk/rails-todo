tasks = document.getElementById("tasks-container")
tasks.innerHTML = "<%= j render(@tasks) %>"

notice = document.getElementById("notice")
if notice
  notice.style.display = "none"