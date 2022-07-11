THEME_VERSION := v0.32.4
THEME := hugo-geekdoc
THEMEDIR := themes

serve:
	hugo serve

build:
	hugo --minify

install:
	rm -rf $(THEMEDIR)/$(THEME)
	mkdir -p $(THEMEDIR)/$(THEME)/ ; \
	curl -sSL "https://github.com/thegeeklab/$(THEME)/releases/download/${THEME_VERSION}/$(THEME).tar.gz" | tar -xz -C $(THEMEDIR)/$(THEME)/ --strip-components=1
	patch -p0 < themes/doc.patch
	#spec
	git submodule update --init

update-spec-version:
	# update spec
	git submodule foreach git pull origin main

