//============================================
// Name          :   ipaddress.go
// Author        :   Marcin Grzegorz Kaspryk
// Version       :   1.0.1
// Copyright     :   ASL
// Description   :   ipaddress
//============================================

package ipaddress

import (
	"net"
)

// GetIPAddress gets the ip address of visited website
func GetIPAddress(address string) (IP net.IP, err error) {

	ips, _ := net.LookupIP(address)
	for _, ip := range ips {
		if ipv4 := ip.To4(); ipv4 != nil {
			return ipv4, err
		}
	}
	return IP, err
}
