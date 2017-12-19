ROLLNAME	= kernel-org
RELEASE		= 0
COLOR		= pink

REDHAT.ROOT	= $(CURDIR)
VERSION		:= $(shell /usr/bin/cat $(CURDIR)/src/kernel-org/version.mk | /usr/bin/awk '/^VERSION/{print $$NF}')
ISOSIZE		= 0
