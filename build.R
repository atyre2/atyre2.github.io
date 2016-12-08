build <- function(input){
  
  #knitr::render_jekyll()

  # input/output filenames are passed as two additional arguments to Rscript
  d = gsub('^_[a-zA-Z]+\\/|[.][a-zA-Z]+$', '', input)
  # knitr::opts_chunk$set(
  #   fig.path   = sprintf('figure/%s/', d),
  #   cache.path = sprintf('_cache/%s/', d)
  # )
  
  output = sprintf('%s-%s.md',Sys.Date(),d)

  #knitr::opts_knit$set(width = 70,
  #                     base.url = "/")
  rmarkdown::render(input, output_file=output, 
                    quiet = TRUE, 
                    encoding = 'UTF-8', 
                    envir = new.env())
}
