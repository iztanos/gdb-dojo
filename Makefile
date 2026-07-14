.PHONY: reset-progress clean-guided-basics

reset-progress:
	rm -rf .dojo

clean-guided-basics:
	$(MAKE) -C levels/guided/00-basics/00-build-and-run clean
	$(MAKE) -C levels/guided/00-basics/01-run-in-gdb clean
	$(MAKE) -C levels/guided/00-basics/02-first-breakpoint clean
	$(MAKE) -C levels/guided/00-basics/03-inspect-locals clean
	$(MAKE) -C levels/guided/00-basics/04-step-into-functions clean
	$(MAKE) -C levels/guided/00-basics/05-basics-capstone clean
