.PHONY: all data clean

all: data data/eda-output.txt data/regression.RData report/report.Rmd

data: 
	curl -0 http://www-bcf.usc.edu/~gareth/ISL/Advertising.csv > data/Advertising.csv

data/regression.RData: code/regression-script.R data/Advertising.csv
	Rscript code/regression-script.R

data/eda-output.txt: code/eda-script.R data/Advertising.csv
	Rscript code/eda-script.R

report/report.Rmd: data/regression.RData images/scatterplot-tv-sales.png data/eda-output.txt
	cd report; Rscript -e 'library(rmarkdown); render("report.Rmd")'

# report/report.pdf: report/report.Rmd
# 	pandoc -s report/report.Rmd -o report/report.pdf

clean: 
	rm -f report/report.pdf