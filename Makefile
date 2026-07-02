.PHONY: reset-progress clean-story-0

reset-progress:
	rm -rf .dojo

clean-story-0:
	$(MAKE) -C levels/story/00-lobby/00-welcome-desk clean
	$(MAKE) -C levels/story/00-lobby/01-glass-box clean
	$(MAKE) -C levels/story/00-lobby/02-moving-door clean
