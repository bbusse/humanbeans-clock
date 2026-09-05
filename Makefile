# Flutter has no strip step and the Linux/web bundles come out of the
# container build (./build.sh), so `build` wraps that. macOS needs Xcode
# and a Flutter SDK on the host, see README.md.
#
# release / rc tag HEAD as release-<hash> / rc-<hash> and push the tag,
# which triggers .github/workflows/release.yml (lives on the ci branch).
DIST ?= dist
APP_NAME ?= Eventually
MACOS_APP = build/macos/Build/Products/Release/$(APP_NAME).app
HASH   := $(shell git rev-parse --short HEAD)
REMOTE ?= gh
RELEASE_BRANCH ?= ci

all: build

build:
	./build.sh

# macOS cannot be built in the container: needs Xcode and a Flutter SDK on
# the host (brew install --cask flutter). Output goes next to the container
# artifacts, dist/macos/$(APP_NAME).app
macos:
	flutter build macos --release
	rm -rf "$(DIST)/macos"
	mkdir -p "$(DIST)/macos"
	cp -R "$(MACOS_APP)" "$(DIST)/macos/"
	@printf 'macOS app : %s/macos/%s.app\n' "$(DIST)" "$(APP_NAME)"

test:
	flutter analyze
	flutter test

clean:
	flutter clean
	rm -rf $(DIST)

_check-remote:
	@git remote get-url $(REMOTE) > /dev/null 2>&1 || \
	    { echo "Error: no remote '$(REMOTE)' — add one with: git remote add $(REMOTE) <url>"; exit 1; }

_check-branch:
	@current="$$(git rev-parse --abbrev-ref HEAD)"; \
	if [ "$$current" != "$(RELEASE_BRANCH)" ]; then \
	    echo "Error: on branch '$$current' — releases must be tagged from '$(RELEASE_BRANCH)'. Checkout $(RELEASE_BRANCH) first."; \
	    exit 1; \
	fi

_check-up-to-date: _check-remote _check-branch
	@git fetch $(REMOTE) $(RELEASE_BRANCH) > /dev/null 2>&1
	@git merge-base --is-ancestor $(REMOTE)/$(RELEASE_BRANCH) HEAD || \
	    { echo "Error: $(RELEASE_BRANCH) has commits you don't have — pull/rebase before tagging a release."; exit 1; }

release: _check-up-to-date
	$(eval TAG := release-$(HASH))
	git tag -f $(TAG)
	@printf 'Tagged %s as %s\n' "$(HASH)" "$(TAG)"
	@printf 'Push tag to trigger a release? [y/N] ' && read ans && \
	    case "$$ans" in [yY]) git push $(REMOTE) $(TAG) ;; \
	    *) git tag -d $(TAG); echo 'Aborted — tag removed.' ;; esac

release-candidate rc: _check-up-to-date
	$(eval TAG := rc-$(HASH))
	git tag -f $(TAG)
	@printf 'Tagged %s as %s\n' "$(HASH)" "$(TAG)"
	@printf 'Push tag to trigger a release candidate? [y/N] ' && read ans && \
	    case "$$ans" in [yY]) git push $(REMOTE) $(TAG) ;; \
	    *) git tag -d $(TAG); echo 'Aborted — tag removed.' ;; esac

.PHONY: all build macos test clean release release-candidate rc _check-remote _check-branch _check-up-to-date
