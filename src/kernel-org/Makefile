# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 6.2 (SideWinder)
# 		         version 7.0 (Manzanita)
# 
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$
# Revision 1.2  2012/11/27 00:49:07  phil
# Copyright Storm for Emerald Boa
#
# Revision 1.1  2012/07/15 18:55:55  phil
# Make a roll that supports kernel.org kernels
#
#
include version.mk
TAR = /bin/tar
ARCH = $(shell /bin/uname -p)
REDHAT.ROOT = $(CURDIR)/../../
PATCHES = None 

## Following Definitions to Patch for WEB10G Stats
## This only works for a few versions of kernels
ifdef WEB10G
PATCHES += $(ESTATSPATCH)
DISTCONFIG = config-$(VERSION)-WEB10G
endif

## Grabs the RHEL spec definition parts that will create a compatible
## kernel, kernel-devel, kernel-headers package triple
rpm pkg: RPMDIRS .rpmmacros config
	( 								\
		export HOME=$(CURDIR);					\
		cd $(NAME)-$(VERSION);					\
		$(MAKE) -j 4 rpm-pkg  \
	)
	

.rpmmacros:
	echo "%_topdir $(REDHAT.ROOT)" > .rpmmacros
	echo "%_buildrootdir $(CURDIR)/$(NAME)-$(VERSION).buildroot" >> .rpmmacros
	echo "%_buildroot $(CURDIR)/$(NAME)-$(VERSION).buildroot" >> .rpmmacros
	echo "%_var	/var" >> .rpmmacros

unpack: $(NAME)-$(VERSION)

$(NAME)-$(VERSION):
	xzcat $(NAME)-$(VERSION).$(TARBALL_POSTFIX) | $(TAR) -xf -
	(cd $(NAME)-$(VERSION); \
	 for p in $(PATCHES); do \
		if [ -f ../$$p ]; then patch -p1 <  ../$$p; fi; \
	 done )

config: unpack
	if [ ! -f  $(USERCONFIG) ]; then /bin/cp $(DISTCONFIG) $(USERCONFIG); fi
	/bin/cp $(USERCONFIG) $(CONFIG)

menuconfig: unpack
	cd $(NAME)-$(VERSION); make mrproper menuconfig
	/bin/cp $(CONFIG) $(USERCONFIG)
	
RPMDIRS:
	if [ ! -d $(REDHAT.ROOT)/RPMS/$(ARCH) ]; then \
		mkdir -p $(REDHAT.ROOT)/RPMS/$(ARCH); fi
	if [ ! -d $(REDHAT.ROOT)/SRPMS ]; then \
		mkdir -p $(REDHAT.ROOT)/SRPMS; fi

clean:
	-rm -rf $(NAME)-$(VERSION)
	-rm -rf $(NAME)-$(VERSION).buildroot
	-rm  .rpmmacros
