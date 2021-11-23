shiny::shinyServer(function(input, output, session) {

source(file.path('server', 'func.R'), local = TRUE)$value

source(file.path('server', 'main.R'), local = TRUE)$value

# hide loader & show app div
shinyjs::hide(id='loader', anim=TRUE, animType='fade')
shinyjs::show("app-content")

})
