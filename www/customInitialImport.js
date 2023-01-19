shinyjs.buildImport = function(params){
  var defaultParams = {
    id: null
  };

  params = shinyjs.getParams(params, defaultParams);

  var id = params.id;

  if(!document.getElementById(id)){
    var stylesheetlink = document.createElement("link");
    stylesheetlink.setAttribute("href", "style.css");
    stylesheetlink.setAttribute("rel","stylesheet");
  
    var head = document.querySelector("head");
    head.appendChild(stylesheetlink);
  
    var file1 = document.createElement("input");
    file1.setAttribute("id", id);
    file1.setAttribute("name", id);
    file1.setAttribute("type", "file");
    file1.setAttribute("multiple", "multiple");
    file1.setAttribute("class", "btn btn-default action-button");
    file1.setAttribute("style","display: none");
  
    var file1Span = document.createElement("span");
    file1Span.setAttribute("class","btn btn-default btn-file");
    file1Span.setAttribute("style","border-radius: ")
    file1Span.innerHTML = "Browse...";
    file1Span.appendChild(file1);
  
    var fileChosen = document.createElement("input");
    fileChosen.setAttribute("id",id+"chosen");
    fileChosen.setAttribute("type","text");
    fileChosen.setAttribute("class","form-control");
    fileChosen.setAttribute("placeholder","Select file");
    fileChosen.setAttribute("readonly","readonly");
  
    var file1ButtonLabel = document.createElement("label");
    file1ButtonLabel.setAttribute("class","input-group-btn input-group-prepend");
    file1ButtonLabel.appendChild(file1Span);
  
    var fileInputGroup = document.createElement("div");
    fileInputGroup.setAttribute("class", "input-group");
    fileInputGroup.appendChild(file1ButtonLabel);
    fileInputGroup.appendChild(fileChosen);
  
    var file1label = document.createElement("label");
    file1label.setAttribute("class","control-label");
    file1label.setAttribute("id","upload-label");
    file1label.setAttribute("for",id);
    file1label.innerHTML = "Select FLIPR data:";
  
    var progressspan = document.createElement("span");
    progressspan.setAttribute("id",id+"uploadBar");
    progressspan.setAttribute("style","width: 0%");
  
    var progressbar = document.createElement("div");
    progressbar.setAttribute("class", "meter nostripes");
    progressbar.appendChild(progressspan);
  
    var form = document.getElementById(id + "sidebar");
    form.appendChild(file1label);
    form.appendChild(fileInputGroup);
    form.appendChild(progressbar);
  
    file1.addEventListener("change", handleSubmit);
  }

}

var globalId;

function handleSubmit(event){
  // sets progress bar to 57%
  var id = event.target.id;
  globalId = id;
  var progressspan = document.getElementById(id + "uploadBar")
  var file1 = document.getElementById(id);
  var fileChosen = document.getElementById(id+"chosen");
  progressspan.setAttribute("style","width: 57%");
  $("uploadBar").each(function() {
    $(this)
      .data("origWidth", $(this).width())
      .width(0)
      .animate({
        width: $(this).data("origWidth") // or + "%" if fluid
      }, 1200);
  });

  // Stop the form from reloading the page
  event.preventDefault();

  // If there's no file do nothing
  if (!file1.files.length) return;

  // else read the files into file1
  let fn = file1.files[0].name;
  let reader = new FileReader();
  fileChosen.value = fn;  
  reader.onload = logNonExcelFile;
  reader.readAsText(file1.files[0]);
  return;
}

function logNonExcelFile(event){
    let str = event.target.result;
    let progressspan = document.getElementById(globalId + "uploadBar")
    // pass the file to Shiny and give it the variable name input$file1
    Shiny.setInputValue(globalId, str);

    // modifies the progress bar to 100%
    progressspan.setAttribute("style","width: 100%");
    $("uploadBar").each(function() {
      $(this)
        .data("origWidth", $(this).width())
        .width(57)
        .animate({
          width: $(this).data("origWidth") // or + "%" if fluid
        }, 1200);
    });

    console.log("file uploaded");
}
