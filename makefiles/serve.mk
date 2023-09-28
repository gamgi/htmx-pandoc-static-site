# Python HTTP server


# Commands
PYTHON						?= python3


# Options
EXT_SERVE_SRCDIR			?= .
EXT_SERVE_PORT				?= 8000


# Actions
.PHONY: serve
serve:
	@$(PYTHON) -m http.server $(EXT_SERVE_PORT) --directory $(EXT_SERVE_SRCDIR)