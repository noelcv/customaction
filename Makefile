KEYWORD=DEPLOY
#attention to the indentation: Makefiles expects tabs instead of spaces
# build the image before running with the default keyword
run: build
	docker run --rm keyword-release-action $(KEYWORD)

# use the dockerfile to compile the docker image and tag it with keyword-release-action	
build:
	docker build --tag keyword-release-action .

# runs the entrypoint.sh script with the test keyword
test:
	./entrypoint.sh $(KEYWORD)