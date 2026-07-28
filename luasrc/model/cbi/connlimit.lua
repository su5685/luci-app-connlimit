local m, s, o

m = Map("connlimit", translate("Connlimit 新建连接限制 (nftables)"),
translate("基于nftables ct count 限制网段出站新建连接，超出连接数直接丢弃新建会话"))

s = m:section(TypedSection, "rule", translate("限制规则列表"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

o = s:option(Flag, "enable", translate("启用本条规则"))
o.rmempty = false

o = s:option(Value, "subnet", translate("源网段"))
o.placeholder = "192.168.10.0/24"
o.datatype = "cidr"

o = s:option(Value, "exclude_dst", translate("排除目标IP"))
o.placeholder = "192.168.10.1"
o.datatype = "ipaddr"

o = s:option(Value, "max_new_conn", translate("最大新建连接数"))
o.default = 500
o.datatype = "uinteger"

return m
