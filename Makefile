.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'


.PHONY: secret
secret: # copy secret file from local. don't commit your change in sample file
	@cp Sources/TwitterService/Secret.swift.sample Sources/TwitterService/Secret.generated.swift
