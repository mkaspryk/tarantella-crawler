package ipaddress

import (
	"net"
)

// GetIPAddress gets the ip address of visited website
func GetIPAddress(address string) net.IP {

	ips, _ := net.LookupIP(address)
	for _, ip := range ips {
		if ipv4 := ip.To4(); ipv4 != nil {
			return ipv4
		}
	}
	return nil
}
