V=20211028

PREFIX = /usr/local

# HOLO: archlinux{.gpg,-trusted,-revoked,-keyring} -> holo
install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 holo.gpg $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 holo-trusted $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 holo-revoked $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/holo{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=holo-keyring-$(V)/ $(V) | gzip -9 > holo-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent holo-keyring-$(V).tar.gz

upload:
	scp holo-keyring-$(V).tar.gz holo-keyring-$(V).tar.gz.sig repos.archlinux.org:/srv/ftp/other/holo-keyring/

.PHONY: install uninstall dist upload
