navbarMenu("More",
    tabPanel("Stuff",
        verbatimTextOutput("summary")
    ),
    tabPanel("About",
        fluidRow(
            column(6,
                "some more text"
            )
        )
    )
)
