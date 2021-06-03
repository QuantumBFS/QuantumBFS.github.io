using Franklin, JSON
using Markdown, Dates

const DATEFMT = dateformat"yyyy-mm-dd HH:MMp"
const TZ = "America/New_York"

function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function hfun_plutonotebookpage(params)
  path = params[1]
  path_to_html = if endswith(path, ".jl")
      path[1:end-3] * ".html"
  else
      path * ".html"
  end

  @info abspath(path_to_html)

  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Feature-Policy#directives

  return """
  <div class="content">
  <iframe id="myiFrame" width="100%" height="100%"
  src="$(path_to_html)"
  class="plutopage"
  frameborder="0"
  allow="accelerometer; ambient-light-sensor; autoplay; battery; camera; display-capture; document-domain; encrypted-media; execution-while-not-rendered; execution-while-out-of-viewport; fullscreen; geolocation; gyroscope; layout-animations; legacy-image-formats; magnetometer; microphone; midi; navigation-override; oversized-images; payment; picture-in-picture; publickey-credentials-get; sync-xhr; usb; wake-lock; screen-wake-lock; vr; web-share; xr-spatial-tracking"
  allowfullscreen></iframe>
  <script src="https://cdn.jsdelivr.net/npm/iframe-resizer@4.2.11/js/iframeResizer.min.js"></script>
  <script> iFrameResize({ log: true, heightCalculationMethod: 'taggedElement' }, '#myiFrame') </script>	
 
  <a class="smallscreenlink" href="$(path_to_html)"></a></div>
  """
end

function hfun_doc(params)
  fname = join(params[1:max(1, length(params)-2)], " ")
  head = params[end-1]
  type = params[end]
  doc = eval(Meta.parse("@doc $fname"))
  txt = Markdown.plain(doc)
  # possibly further processing here
  body = Franklin.fd2html(txt, internal=true)
  return """
    <div class="docstring">
        <h2 class="doc-header" id="$head">
          <a href="#$head">$head</a>
          <div class="doc-type">$type</div></h2>
        <div class="doc-content">$body</div>
    </div>
  """
end

function hfun_tutorial_sidebar()
	items = []
	for each in readdir("tutorials/notebooks/Pluto/")
		if endswith(each, ".jl")
			name = each[1:end-3]
			push!(items, "<a class=\"sidebar-nav-item\" href=\"/hw0/\">$name</a>")
		end
	end
	@info join(items)
	return join(items)
end
