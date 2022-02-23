MD_PORT := 8000

.PHONY: local
local:
	mdbook serve -p $(MD_PORT) --open
