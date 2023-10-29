;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns.alonsobivou.com. admin.alonsobivou.com. (
			      6		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
	IN 	NS	ns.alonsobivou.com.
;
ns.alonsobivou.com.	IN	A	192.168.134.1
cloud.alonsobivou.com.	IN	A	192.168.134.1
