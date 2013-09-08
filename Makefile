all:
	@echo "Scripts only, nothing to build"

install:
	install -D -T freewifi-register.sh $(DESTDIR)/usr/bin/freewifi-register
	install -D -T freewifi-dispatcher.sh $(DESTDIR)/etc/NetworkManager/dispatcher.d/freewifi-dispatcher.sh
	install -D -T freewifi.conf $(DESTDIR)/etc/freewifi.conf
