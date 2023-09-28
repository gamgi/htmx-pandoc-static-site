define targetargs
$(filter-out $@,$(MAKECMDGOALS))
endef
