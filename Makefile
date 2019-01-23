ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
OUTPUT_DIR := ./protos


clean-output:
	rm -rf ${OUTPUT_DIR}
	mkdir ${OUTPUT_DIR}


generate: clean-output
	docker run --rm -v `pwd`:`pwd` -w `pwd` znly/protoc --python_out=${OUTPUT_DIR} -I . *.proto

	docker run --rm -v `pwd`:`pwd` -w `pwd` znly/protoc \
	--plugin=protoc-gen-grpc=/usr/bin/grpc_python_plugin \
	--python_out=${OUTPUT_DIR} \
	--grpc_out=${OUTPUT_DIR} \
	-I . *.proto
