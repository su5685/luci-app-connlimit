#!/bin/sh

NFT="/usr/sbin/nft"
TABLE="inet connlimit"

# 重建表
$NFT delete table $TABLE 2>/dev/null
$NFT add table $TABLE

$NFT add chain $TABLE forward_hook { type filter hook forward priority -1000\; policy accept\; }

config_load connlimit
add_rule() {
	local enable subnet exclude_dst max_new_conn
	config_get enable "$1" enable
	config_get subnet "$1" subnet
	config_get exclude_dst "$1" exclude_dst
	config_get max_new_conn "$1" max_new_conn

	[ "$enable" != "1" ] && return
	[ -z "$subnet" ] || [ -z "$exclude_dst" ] || [ -z "$max_new_conn" ] && return

	$NFT add rule $TABLE forward_hook ip saddr $subnet ip daddr != $exclude_dst ct state new ct count over $max_new_conn counter drop
}

config_foreach add_rule rule
