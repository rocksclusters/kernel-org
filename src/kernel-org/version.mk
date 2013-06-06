PKGROOT		= /opt/kernel-org
NAME        = linux
VERSION     = 3.4.4
RELEASE 	= 1
TARBALL_POSTFIX	=  tar.bz2

# Uncomment the following WEB10G line to indicate
# estats Patch should be applied. Patch is kernel specific
# WEB10G = 1
ESTATSPATCHVER = 0.3-3.4
ESTATSPATCH = estats-nl-$(ESTATSPATCHVER).patch

DISTCONFIG  = config-$(VERSION).dist
USERCONFIG  = config-$(VERSION)
CONFIG = 	$(NAME)-$(VERSION)/.config
