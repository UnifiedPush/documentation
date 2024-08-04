THEME_VERSION := v0.44.0
THEME := hugo-geekdoc
THEMEDIR := themes

serve:
	hugo serve

build:
	hugo --minify

publish:
	ls -la ~/ ~/.ssh
	git clone git@codeberg.org:UnifiedPush/pages.git
	sed -i '/relativeURLs/ s/true/false/' config.toml
	hugo --minify
	rm -rf public/includes/spec/
	cp -r pages/.git public/
	# 1 line, to stay in public dir
	cd public && git add . && git commit -m "Update doc" && git push

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

