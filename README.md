This is the GitHub repository for the Yao Framework's main website, [yaoquantum.org](https://yaoquantum.org).

The Yao website is generated using GitHub pages and [Franklin.jl](https://github.com/tlienart/Franklin.jl), a Julia native package for building static websites.

## Making Simple Changes

To suggest a change to the website, you can simply navigate to the page with the content you think should be changed, and edit it.
You will be prompted to fork the repo (if you haven't already) and then open a Pull Request.
Once your Pull Request is merged, you should see your changes show up on the website in a few minutes or less.

Build previews for each Pull Request will be linked in the comment section of the PR once the site has been successfully build.

**Note**: please only use _fenced_ code blocks (i.e. code blocks delimited by backticks) and not indented code blocks.

## Making modifications and seeing the changes locally

Clone the repository and `cd` to it. Start julia with `julia --project` and do

```julia
julia> using Pkg; Pkg.instantiate()

julia> using Franklin

julia> serve()
→ Initial full pass...
→ evaluating code [...] (learning/code-examples.md)
→ Starting the server...
✓ LiveServer listening on https://localhost:8000/ ...
  (use CTRL+C to shut down)
```

Navigate to `localhost:8000` in a browser and you should see a preview of any modifications you make locally.

**Modifying the CSS**: modify the relevant files in `_css/`.

**Modifying the HTML structure**: if you want to modify the navbar, or the footer, go to `_layout/` and modify the relevant template fragment.

**Modifying the landing page**: since the landing page has its own design, it is written in HTML with a few insertions of repurposeable fragments where appropriate, just modify `index.html`
