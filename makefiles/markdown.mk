# Pandoc markdown to HTML


# Commands
PANDOC 						?= pandoc
MARKDOWN 				 	 = $(PANDOC) --from gfm --to html


# Options
EXT_MARKDOWN_SRCDIR			?= pages
EXT_MARKDOWN_DESTDIR		?= build
EXT_MARKDOWN_FRAGDIR		?= partials
EXT_MARKDOWN_OPTIONS 		?= ""
EXT_MARKDOWN_DO_PARTS		?= false
EXT_MARKDOWN_DO_STANDALONE	?= true


# Internals
MARKDOWN_FRAG_SOURCES		:= $(wildcard $(EXT_MARKDOWN_FRAGDIR)/*.html)
MARKDOWN_PAGE_SOURCES 		:= $(wildcard $(EXT_MARKDOWN_SRCDIR)/*.md)
MARKDOWN_OUTPUTS			:= # Empty
ifeq ($(EXT_MARKDOWN_DO_STANDALONE), true)
MARKDOWN_OUTPUTS			:= $(patsubst $(EXT_MARKDOWN_SRCDIR)/%.md,$(EXT_MARKDOWN_DESTDIR)/%.html,$(MARKDOWN_PAGE_SOURCES))
endif
ifeq ($(EXT_MARKDOWN_DO_PARTS), true)
MARKDOWN_OUTPUTS			+= $(patsubst $(EXT_MARKDOWN_SRCDIR)/%.md,$(EXT_MARKDOWN_DESTDIR)/%.html.part,$(MARKDOWN_PAGE_SOURCES))
endif


# Actions
.PHONY: markdown
markdown: $(MARKDOWN_OUTPUTS)

.PHONY: cleanext
cleanext::
	$(info cleaning markdown)
	test -n "$(EXT_MARKDOWN_DESTDIR)" && $(RM) -r $(EXT_MARKDOWN_DESTDIR)/*


# Targets
$(EXT_MARKDOWN_DESTDIR)/%.html: $(EXT_MARKDOWN_SRCDIR)/%.md $(MARKDOWN_FRAG_SOURCES) Makefile
	@mkdir -p $(@D)
	$(MARKDOWN) -V standalone="true" $(EXT_MARKDOWN_OPTIONS) $< --output $@

$(EXT_MARKDOWN_DESTDIR)/%.html.part: $(EXT_MARKDOWN_SRCDIR)/%.md $(MARKDOWN_FRAG_SOURCES) Makefile
	@mkdir -p $(@D)
	$(MARKDOWN) $(EXT_MARKDOWN_OPTIONS) $< --output $@
