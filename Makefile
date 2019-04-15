BAUD=4800
NODEMCU=nodemcu-tool -b ${BAUD}

BUILD_DIR=build
SRC_DIR=lua

src_files := $(patsubst $(SRC_DIR)%.lua,$(BUILD_DIR)%.lua,$(wildcard $(SRC_DIR)/*.lua))

.PHONY: clean all flash terminal fsinfo upload

all: upload

upload: $(src_files)

clean:
	rm -rf ${BUILD_DIR}

fsinfo:
	$(NODEMCU) fsinfo

terminal:
	$(NODEMCU) terminal

restart:
	echo -e "\nnode.restart()\n" | $(NODEMCU) terminal

flash:
	esptool -b 230400 write_flash 0x00000 firmware/0x00000.bin 0x10000 firmware/0x10000.bin

$(BUILD_DIR)/%.lua: $(SRC_DIR)/%.lua
	$(NODEMCU) upload $(<)
	mkdir -p $(BUILD_DIR)
	touch $(@)
