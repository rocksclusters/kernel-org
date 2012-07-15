PKGROOT		= /opt/kernel-org
NAME        = linux
VERSION     = 3.4.4
RELEASE 	= 1
TARBALL_POSTFIX	=  tar.bz2
DISTCONFIG  = config-$(VERSION).dist
USERCONFIG  = config-$(VERSION)
CONFIG	=	$(NAME)-$(VERSION)/.config
