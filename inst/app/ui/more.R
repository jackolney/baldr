navbarMenu("More",
    tabPanel("Manual",
        HTML('<iframe src=\"https://jackolney.github.io/modelr/manual\"style=\"border: 0; position:absolute; top:50px; left:0; right:0; width:100%; height:100%\"></iframe>')
    ),
    tabPanel("Diagnostics",
        verbatimTextOutput(outputId = "diagnostics")
    )
)
