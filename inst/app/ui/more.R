navbarMenu("More",
    tabPanel("Diagnostics",
        verbatimTextOutput(outputId = "diagnostics")
    ),
    tabPanel("About",
        "Jack made this.",
        a(href = "https://jackolney.github.io/modelr/manual", "modelr manual", target = "_blank")
    )
)
