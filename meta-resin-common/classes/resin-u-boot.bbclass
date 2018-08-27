FILESEXTRAPATHS_append := ":${RESIN_COREBASE}/recipes-bsp/u-boot/patches"

# Machine independent patches
SRC_URI_append = " \
    file://env_resin.h \
    "

RESIN_BOOT_PART = "1"
RESIN_DEFAULT_ROOT_PART = "2"
RESIN_ENV_FILE = "resinOS_uEnv.txt"
RESIN_UBOOT_DEVICES ?= "0 1 2"
RESIN_KERNEL_IMAGETYPE ?= "${KERNEL_IMAGETYPE}"

do_generate_resin_uboot_configuration () {
    cat > ${S}/include/config_resin.h <<EOF
#define RESIN_UBOOT_DEVICES ${RESIN_UBOOT_DEVICES}
#define RESIN_BOOT_PART ${RESIN_BOOT_PART}
#define RESIN_DEFAULT_ROOT_PART ${RESIN_DEFAULT_ROOT_PART}
#define RESIN_IMAGE_FLAG_FILE ${RESIN_IMAGE_FLAG_FILE}
#define RESIN_FLASHER_FLAG_FILE ${RESIN_FLASHER_FLAG_FILE}
#define RESIN_ENV_FILE ${RESIN_ENV_FILE}
#define RESIN_KERNEL_IMAGETYPE ${RESIN_KERNEL_IMAGETYPE}
EOF

    cp ${WORKDIR}/env_resin.h ${S}/include/env_resin.h
}
addtask do_generate_resin_uboot_configuration after do_patch before do_configure
