function generate(title, file)
    page = """
    <!DOCTYPE html>
    <html lang="en">
        <head>
            {{insert meta.html}}
            {{insert head_scripts.html}}
            <link rel="stylesheet" href="/css/tutorial.css">
            <title>$title | Yao Tutorial</title>
        </head>

        <body>
            <div class="main">
                <header>
                    {{ insert nav.html }}
                </header>

                <div class="tutorial-container">
                    {{ insert sidebar.html }}
                    {{ plutonotebookpage /notebooks/$file.jl }}
                </div>
                {{ insert foot_general.html }}
            </div>
        </body>
    </html>
    """
    write(joinpath("tutorials", "$file.html"), page)
end

function generate(sections)
    for ((title, dir), pages) in sections
        sec_path = joinpath("tutorials", dir)
        ispath(sec_path) || mkpath(sec_path)
        for (page_title, file) in pages
            @info "generating section $title: $file"
            generate(page_title, joinpath(dir, file))
        end
    end
end

function sidebar(sections)
    section_htmls = []
    for ((title, dir), pages) in sections
        page_htmls = []
        for (page_title, file) in pages
            @info "generating section $title: $file"
            page_link = "/tutorials/$dir/$file/"
            push!(page_htmls, """
            <a class="sidebar-nav-item {{ispage $page_link}}active{{end}}" href="$page_link"><b>$page_title</b></a>
            """)
        end
        
        push!(section_htmls, """
        <div class="course-section">$title</div>
        $(join(page_htmls))
        <br>
        """)
    end
    write("_layout/sidebar.html", """
    <div class="sidebar">
    <div class="container sidebar-sticky">
      <nav class="sidebar-nav" style="opacity: 0.9">
        $(join(section_htmls))
      </nav>
    </div>
    </div>
    """)
end

import PlutoSliderServer
PlutoSliderServer.github_action(;Export_baked_state=false)

ispath("__site/notebooks") || mkpath("__site/notebooks")
cp("notebooks", "__site/notebooks"; force=true)

pages = [
    ("Quick Start", "quick-start") => [
        "Setup Your Environment" => "0.setup",
        "Julia Basics" => "1-julia_basics",
        "Yao Basics" => "2.yao_basics",
    ],
    ("Getting Started", "getting-started") => [
        "Introduction" => "1-introduction"
        "Gates & Qubits" => "2-gates_and_qubits"
        "Programming with Yao" => "3-yao_code"
        "Applications" => "4-applications"
        "More Quantum Gates" => "5-more_gates"
        "Quantum Arithmetic" => "6-quantum_arithmetic"
        "Grover Algorithm" => "7-grovers"
        "Deutsch Algorithm" => "8-deutsch"
        "Simon Algorithm" => "9-simon"
        "QRAM" => "10-qram"
        "Assignment" => "assignment1"
    ],
]

generate(pages)
sidebar(pages)
