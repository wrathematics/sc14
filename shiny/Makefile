export PATH := /usr/lib/rstudio/bin/pandoc:$(PATH)


shinytalk.html: shinytalk.Rmd
	Rscript -e 'rmarkdown::render("shinytalk.Rmd")'


.PHONY: clean

clean: 
	rm -f shinytalk.html
