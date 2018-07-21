polymersNONSTOP?= -interaction=nonstopmode
BIN=bin
BINPATH=$(BIN)/
BUILD=_build
BUILDPATH=$(BUILD)/
FIGPATH=figures/
IMAGEPATH=generated_pictures/
GKAPPAREP=$(HOME)/GKappa/_build/sources

DOT=$(wildcard $(FIGPATH)*.dot)
DOT2 = $(wildcard $(BUILD)/*.dot)
DOT3 = $(patsubst $(BUILD)%,$(IMAGEPATH)%,$(DOT2))

LADOT2 = $(wildcard $(BUILD)/*.ladot)
LADOT3 = $(patsubst $(BUILD)%,$(IMAGEPATH)%,$(LADOT2))

OCAMLFIG=$(wildcard $(FIGPATH)*.figs.ml)
OCAMLFIG2=$(patsubst $(FIGPATH)%,$(BINPATH)%,$(OCAMLFIG))
OCAMLBIN=$(OCAMLFIG2:%.figs.ml=%)
OCAMLSIG=$(wildcard $(FIGPATH)*.sig.ml)
OCAMLSIG2=$(OCAMLSIG:%.sig.ml=%.ml)
SIGML=$(patsubst $(FIGPATH)%,$(BUILDPATH)%,$(OCAMLSIG2))
SIGCMX=$(SIGML:%.ml=%.cmx)

MACRO=$(wildcard *.sty)

HTML=

PDFFIG=$(wildcard $(FIGPATH)*.pdf)

FIG=$(wildcard $(FIGPATH)*.fig)
CHAPTERS=$(wildcard *.tex)
PREFIG=$(patsubst $(FIGPATH)%,$(IMAGEPATH)%,$(FIG))
PREGPLOT=$(patsubst $(GNUPLOTPATH)%,$(IMAGEPATH)%,$(GNUPLOT))
TEX=$(PREFIG:%.fig=%.pdf_t) $(PREGPLOT:%.gplot=%.tex)
PDF=$(PREGPLOT:%.gplot=%.pdf) $(PREFIG:%.fig=%.pdf) $(patsubst $(FIGPATH)%,$(IMAGEPATH)%,$(PDFFIG))  $(patsubst $(FIGPATH)%,$(IMAGEPATH)%,$(DOT:%.dot=%.pdf)) $(patsubst $(FIGPATH)%,$(IMAGEPATH)%,$(PDF3)) $(LADOT3:%.ladot=%.pdf)
JPG=
PNG=

PREIMAGES=$(JPG) $(PNG)
IMAGES= $(IMAGEPATH) $(PDF) $(TEX) $(PREIMAGES:%=$(IMAGEPATH)%)

OCAMLOPT=ocamlopt.opt -I $(BUILD) -I $(GKAPPAREP) data_structures.cmx geometry.cmx gkappa.cmx config.cmx


all: $(BUILD) $(BIN) $(SIGCMX) $(IMAGEPATH) $(OCAMLBIN) $(DATA) $(PREFIG) $(PDF) $(TEX) $(BIB)
	pdflatex $(NONSTOP) polymers
	bibtex polymers
	pdflatex $(NONSTOP) polymers
	pdflatex $(NONSTOP) polymers


short:
	pdflatex $(NONSTOP) polymers
	pdtlatex $(NONSTEP) polymers

$(BIN)/%: $(BUILD)/%.ml $(COMMONCMX) $(SIGCMX) Makefile
	$(OCAMLOPT) $(COMMONCMX) $(SIGCMX) $< -o $@
	cd $(BUILD) ; $(CURDIR)/$@
	$(MAKE) build_tmp all
	$(shell exit 2)

build_tmp: $(TMPTEX) $(TMPPDF)

$(IMAGEPATH)%.pdf: $(BUILDPATH)%.ladot.tex $(BUILDPATH)%.ladot.eps
	rm -rf tmp
	mkdir tmp
	cat fm_header $(BUILDPATH)$(notdir $(basename $@)).ladot.tex > tmp/$(notdir $(basename $@))_fm
	cp $(BUILDPATH)$(notdir $(basename $@)).ladot.eps tmp/$(notdir $(basename $@))_fm.eps
	cd tmp ; fragmaster
	cp tmp/$(notdir $(basename $@)).pdf $@
	rm -rf tmp

$(BUILDPATH)%.ladot.tex: $(BUILDPATH)%.ladot
	cd $(BUILD) ; ladot $(notdir $<)

$(BUILDPATH)%.ladot.eps: $(BUILDPATH)%.ladot
	cd $(BUILD) ; ladot $(notdir $<)


%.ladot: %.dot
	cp $< $@


$(BIN):
	mkdir $(BIN)
$(BUILD):
	mkdir $(BUILD)

$(IMAGEPATH)%.eps: $(GNUPLOTPATH)%.gplot
	gnuplot $<

$(IMAGEPATH)%.tex: $(GNUPLOTPATH)%.gplot
	gnuplot $<

$(IMAGEPATH)%.eps: $(GNUPLOTPATH)%.gplot $(wildcard $(OCTAVEPATH)/*/*.data)
	gnuplot $<

$(IMAGEPATH)%.tex: $(GNUPLOTPATH)%.gplot $(wildcard $(OCTAVEPATH)*/%.gplot) $(wildcard  $(OCTAVEPATH)*/*.data)
	gnuplot $<

$(IMAGEPATH)%.eps: $(GNUPLOTPATH)%.gplot $(wildcard $(OCTAVEPATH)*/%.gplot) $(wildcard  $(OCTAVEPATH)*/*.data)
	gnuplot $<

%.data: %_system.m %_system_aux.m %_system_init.m
	cd $(dir $<) && octave $(notdir $<)

$(BUILD)/%.cmx: $(BUILD)/%.ml Makefile
	cd $(BUILD) ; $(OCAMLOPT) -c $(notdir $<)

$(BUILD)/%.ml: $(FIGPATH)%.sig.ml
	cp $< $@
$(BUILD)/%.ml: $(FIGPATH)%.figs.ml
	cp $< $@

$(IMAGEPATH):
	mkdir $@

$(IMAGEPATH)%.fig: $(FIGPATH)%.fig
	cp $< $@


$(IMAGEPATH)%.pdf_t: $(IMAGEPATH)%.pdf $(IMAGEPATH)%.fig
	fig2dev -L pdftex_t -p $^ $@

$(IMAGEPATH)%.pdf:  $(IMAGEPATH)%.fig
	fig2dev -L pdftex $< $@

$(IMAGEPATH)%.pdf: $(IMAGEPATH)%.eps
	ps2pdf -dEPSCrop $< $@

$(IMAGEPATH)%.pdf: $(FIGPATH)%.pdf
	cp $< $@


demo: $(HTML)

sessions:
	mkdir sessions


clean:
	rm -f *.blg *.out *.toc *.todo *.idx *.bbl *~ \#* *.dvi *.aux *.log  *.bak *.html $(PREIMAGES) $(BBL) $(TEX) $(PDF) $(DATA)
	rm -fr sessions
	rm -fr $(IMAGEPATH) $(BUILD) $(BIN)

clean_all:
	@make clean;
	rm $(OUTPUT)

force:
	rm -f $(OUTPUT)
	@make

nonstop:
	@make NONSTOP=-halt-on-error
