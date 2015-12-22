# Build docker image

# image base name
NAME=apache-php
TEST_NAME=$(NAME)-test

# Image tag
TAG=lsucs/$(NAME)


all: build

build:
	docker build -t $(TAG) .

test: build
	docker run -d --rm --name $(TEST_NAME) -v $(PWD)/testapp:/app:ro -p :80 $(TAG) 
	docker port $(TEST_NAME)

stop:
	docker stop $(TEST_NAME)
