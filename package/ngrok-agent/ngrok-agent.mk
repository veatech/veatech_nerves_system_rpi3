#############################################################
#
# ngrok-agent
#
#############################################################

NGROK_AGENT_SITE = https://bin.equinox.io/c/bNyj1mQVY4c
NGROK_AGENT_SOURCE = ngrok-v3-stable-linux-arm.tgz
NGROK_AGENT_VERSION = 3.0.2
NGROK_AGENT_STRIP_COMPONENTS = 0
HOST_NGROK_AGENT_DEPENDENCIES = host-xz

define NGROK_AGENT_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/ngrok  $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
