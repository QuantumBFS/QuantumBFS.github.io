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
            <script>
                // there is only one pluto notebook load to page each time
                var iframe = document.getElementsByClassName('plutopage')[0];
                iframe.onload =  function () {
                    setTimeout(function() {
                        iframe.height = iframe.contentWindow.document.body.scrollHeight + 'px';
                    }, 500);
                }
            </script>
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
      <a class="sidebar-nav-item {{ispage /tutorials/}}active{{end}}" href="/tutorials/quick-start"><b>Quick Start</b></a>
      <br>
      <nav class="sidebar-nav" style="opacity: 0.9">
        $(join(section_htmls))
      </nav>
    </div>
    </div>
    """)
end

import PlutoUtils
PlutoUtils.Export.github_action(;export_dir=".", baked_state=false)

ispath("__site/notebooks") || mkpath("__site/notebooks")
cp("notebooks", "__site/notebooks"; force=true)

pages = [
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

generate("Quick Start", "quick-start")
generate(pages)
sidebar(pages)
