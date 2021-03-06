VERSION=1.1.0

.PHONY: dist
dist: owncloud-collabora-online.spec info.xml
	rm -rf owncloud-collabora-online-$(VERSION)
	mkdir owncloud-collabora-online-$(VERSION)
	tar cf - --exclude appinfo/info.xml.in *.php \
                appinfo \
                assets \
                controller \
                css \
                img \
                js \
                l10n \
                lib \
                templates \
                | ( cd owncloud-collabora-online-$(VERSION) && tar xf - )
	tar cfz owncloud-collabora-online-$(VERSION).tar.gz owncloud-collabora-online-$(VERSION)
	rm -rf owncloud-collabora-online-$(VERSION)

app: info.xml
	rm -rf richdocuments
	mkdir richdocuments
	tar cf - --exclude appinfo/info.xml.in *.php \
                appinfo \
                assets \
                controller \
                css \
                img \
                js \
                l10n \
                lib \
                templates \
                | ( cd richdocuments && tar xf - )
	zip -r richdocuments.zip richdocuments
	rm -rf richdocuments

owncloud-collabora-online.spec: owncloud-collabora-online.spec.in Makefile
	sed -e 's/@PACKAGE_VERSION@/$(VERSION)/g' <owncloud-collabora-online.spec.in >owncloud-collabora-online.spec

info.xml: appinfo/info.xml.in Makefile
	sed -e 's/@PACKAGE_VERSION@/$(VERSION)/g' <appinfo/info.xml.in >appinfo/info.xml
