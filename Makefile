# Set the diary year you wish to compile and user info
YEAR := 2012
AUTHOR := Colton Williams
INSTITUTION := Amazon.com

# Do not edit past this line
RM := rm -rf
SHELL := /bin/bash

TEXFILE := $(YEAR)-worklog.tex
LOGFILE := $(YEAR)-worklog.log
DVIFILE := $(YEAR)-worklog.dvi
PSFILE := $(YEAR)-worklog.ps
PDFFILE := $(YEAR)-worklog.pdf
AUXFILE := $(YEAR)-worklog.aux
OUTFILE := $(YEAR)-worklog.out

.PHONY : clean

anthology:
	-@echo 'Creating anthology for worklog entries from the year $(YEAR)'
	-@$(SHELL) scripts/create_anthology.sh "$(YEAR)" "$(AUTHOR)" "$(INSTITUTION)"
	-latex -interaction=batchmode -halt-on-error $(TEXFILE) 
	-dvips -q -o "$(PSFILE)" "$(DVIFILE)" -R0
	-ps2pdf "$(PSFILE)" "$(PDFFILE)"
	-okular $(PDFFILE)

clean:
	-$(RM) $(TEXFILE)
	-$(RM) $(LOGFILE) $(DVIFILE) $(PSFILE) $(AUXFILE) $(OUTFILE)
	-$(RM) *.tmp
	-@echo 'Done cleaning'
