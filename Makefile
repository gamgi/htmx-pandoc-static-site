include makefiles/boilerplate.mk
include makefiles/macros.mk
include makefiles/utils.mk


# Options
BUILDDIR					:= docs


# Extensions
EXT_MARKDOWN_DESTDIR		:= $(BUILDDIR)
EXT_MARKDOWN_OPTIONS    	:= -M document-css=true \
							-M mainfont="Arial, 'Helvetica Neue', Helvetica, sans-serif" \
							--css=/style.css \
							--template=template.html5 \
							--shift-heading-level-by=1 \
							--include-in-header=partials/scripts.html \
							--include-before-body=partials/header.html \
							--include-after-body=partials/footer.html
EXT_MARKDOWN_DO_PARTS		:= true
EXT_MARKDOWN_DO_STANDALONE	:= true
include	makefiles/markdown.mk

EXT_SERVE_SRCDIR			:= $(BUILDDIR)
include	makefiles/serve.mk


# Actions
all: markdown styles

styles: $(BUILDDIR)/style.css
.PHONY: styles

clean: cleanext

develop:
	@set -e ; \
	echo "experimental-features = nix-command flakes" >> nix.conf ; \
	docker run -ti \
    	-v "$$(pwd)":/home/root/ \
	 	-v "$$(pwd)/nix.conf":/etc/nix/nix.conf \
	 	--workdir /home/root/ \
		--platform linux/arm64 \
		--publish 8000:8000 \
		nixery.dev/arm64/shell/gnumake/pandoc/python3 \
		$(targetargs)
.PHONY: develop
	
# Targets
$(BUILDDIR)/%.css: %.css
	@$(MKDIR) $(@D)
	$(INSTALL) $< $@


# Noop
make:
    @:
