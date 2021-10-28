.DELETE_ON_ERROR: clean

EXECUTABLES = go
K := $(foreach exec,$(EXECUTABLES),\
  $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH)))

GIT_VERSION  ?= $(shell git rev-parse --abbrev-ref HEAD)
GIT_REVISION ?= $(shell git rev-parse HEAD | tr -d '\040\011\012\015\n')
GIT_BRANCH   ?= $(shell git rev-parse --abbrev-ref HEAD | tr -d '\040\011\012\015\n')
GIT_USER     ?= $(shell git config --get user.name | tr -d '\040\011\012\015\n')
BUILD_DATE   ?= $(shell date +'%Y-%m-%dT%H:%M:%S')

BUILD_DIR      := ./build
DIST_DIR       := ./dist
GO_LDFLAGS     ?= -ldflags "-X github.com/slashdevops/idp-scim-sync/internal/version.Version=$(GIT_VERSION) -X github.com/slashdevops/idp-scim-sync/internal/version.Revision=$(GIT_REVISION) -X github.com/slashdevops/idp-scim-sync/internal/version.Branch=$(GIT_BRANCH) -X github.com/slashdevops/idp-scim-sync/internal/version.BuildUser=\"$(GIT_USER)\" -X github.com/slashdevops/idp-scim-sync/internal/version.BuildDate=$(BUILD_DATE)"
GO_CGO_ENABLED ?= 0
GO_OPTS        ?= -v
GO_OS          ?= darwin linux windows
GO_ARCH        ?= arm arm64 amd64 386
# avoid mocks in tests
GO_FILES       := $(shell go list ./... | grep -v /mocks/)

PROJECTS_PATH := $(shell ls -d cmd/*)
PROJECTS_NAME := $(foreach dir_name, $(PROJECTS_PATH), $(shell basename $(dir_name)) )
PROJECT_DEPENDENCIES := $(shell go list -m -f '{{if not (or .Indirect .Main)}}{{.Path}}{{end}}' all)


all: clean test build

mod-update: tidy
	$(foreach dep, $(PROJECT_DEPENDENCIES), $(shell go get -u $(dep)))
	go mod tidy

tidy:
	go mod tidy

fmt:
	@go fmt $(GO_FILES)

vet:
	go vet $(GO_FILES)

generate:
	go generate $(GO_FILES)

test: generate tidy fmt vet
	go test -race -covermode=atomic -coverprofile coverage.out -tags=unit $(GO_FILES)

test-coverage: test
	go tool cover -html=coverage.out

build:
	$(foreach proj_name, $(PROJECTS_NAME), \
		$(shell CGO_ENABLED=$(GO_CGO_ENABLED) go build $(GO_LDFLAGS) $(GO_OPTS) -o ./$(BUILD_DIR)/$(proj_name) ./cmd/$(proj_name)/ ))

build-dist: build
	$(foreach GOOS, $(GO_OS),\
		$(foreach GOARCH, $(GO_ARCH), \
			$(foreach proj_name, $(PROJECTS_NAME), \
				$(shell GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=$(GO_CGO_ENABLED) go build $(GO_LDFLAGS) $(GO_OPTS) -o ./$(DIST_DIR)/$(proj_name)-$(GOOS)-$(GOARCH) ./cmd/$(proj_name)/ ))))

clean:
	rm -rf $(BUILD_DIR) $(DIST_DIR) ./*.out