THEME_VERSION := v0.44.0
THEME := hugo-geekdoc
THEMEDIR := themes

serve:
	hugo serve

build:
	hugo --minify

publish:
	git clone git@codeberg.org:UnifiedPush/pages.git
	sed -i '/relativeURLs/ s/true/false/' config.toml
	# fix link for hugo
	sed -i -e 's/messageack/message_ack/' -e 's/newendpoint/new_endpoint/' -e 's/registrationfailed/registration_failed/' static/includes/spec/specifications/*.md
	hugo --minify
	rm -rf public/includes/spec/
	rm -rf public/kdoc/.git
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
	cd ./static/includes/spec/
	git pull origin main

