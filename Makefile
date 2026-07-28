include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-connlimit
PKG_VERSION:=2.0
PKG_RELEASE:=1

PKG_MAINTAINER:=self
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-connlimit
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Connlimit nftables 新建连接限制
  DEPENDS:=+nftables +luci-base
endef

define Package/luci-app-connlimit/description
  LuCI UI for nftables ct count limit, limit new connections for source subnet
endef

define Build/Compile
endef

define Package/luci-app-connlimit/install
	$(CP) ./luasrc $(1)/usr/lib/lua/
	$(CP) ./root/* $(1)/
	chmod 755 $(1)/usr/sbin/connlimit-nft.sh
	chmod 755 $(1)/etc/init.d/connlimit
endef

$(eval $(call BuildPackage,luci-app-connlimit))
