module("luci.controller.connlimit", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/connlimit") then
		return
	end

	entry({"admin", "network", "connlimit"}, cbi("connlimit/connlimit"), _("Connlimit连接限制(nft)"), 60)
end
