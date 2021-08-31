.PHONY: secrets
secrets: # copy secret file from local
	@cp Sources/TwitterService/Secret.swift.sample Sources/TwitterService/Secret.generated.swift
