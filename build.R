build <- function(input){
  
  #knitr::render_markdown()
  # extract YAML header
  # input_file <- readLines(input, warn=FALSE)
  # header <- grep("---",input_file)
  # if (length(header) > 2) stop("too much YAML!")
  # yaml_header <- input_file[header[1]:header[2]]

  # input/output filenames are passed as two additional arguments to Rscript
  d = gsub('^_[a-zA-Z]+\\/|[.][a-zA-Z]+$', '', input)
  knitr::opts_chunk$set(
     fig.path   = sprintf('figure/%s/', d),
     cache.path = sprintf('_cache/%s/', d)
  )
  
  output = sprintf('_posts/%s-%s.md',Sys.Date(),d)

  knitr::opts_knit$set(width = 70,
                       base.url = "/")
  # rmarkdown::render(input, output_format = "md_document")
  # md_doc <- readLines(paste0("_drafts/",d,".md"))
  # writeLines(c(yaml_header, md_doc),output)
  knitr::knit(input, output=output, 
                     quiet = TRUE, 
                     encoding = 'UTF-8', 
                     envir = new.env())
}
