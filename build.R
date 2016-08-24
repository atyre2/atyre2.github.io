local({
  
  .libPaths(c("C:/Users/Drew/Documents/R/win-library/3.3",.Library))
  knitr::render_jekyll()

  # input/output filenames are passed as two additional arguments to Rscript
  a = commandArgs(TRUE)
  d = gsub('^_[a-zA-Z]+\\/|[.][a-zA-Z]+$', '', a[1])
  knitr::opts_chunk$set(
    fig.path   = sprintf('figure/%s/', d),
    cache.path = sprintf('cache/%s/', d)
  )
  
  output = sprintf('_posts/%s-%s.md',Sys.Date(),d)
  output = sprintf('%s.md',d)
  
  knitr::opts_knit$set(width = 70,
                       base.url = "/")
  knitr::knit(a[1], output, quiet = TRUE, encoding = 'UTF-8', envir = .GlobalEnv)
})
