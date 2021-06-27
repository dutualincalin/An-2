#include "skel.h"

int interfaces[ROUTER_NUM_INTERFACES];
struct route_table_entry *rtable;
int rtable_size;

struct arp_entry *arp_table;
int arp_table_len;

/*
 Returns a pointer (eg. &rtable[i]) to the best matching route
 for the given dest_ip. Or NULL if there is no matching route.
*/
struct route_table_entry *get_best_route(__u32 dest_ip) {
	int i, idx = -1;

	for(i = 0; i < rtable_size; i++){
		if((dest_ip & rtable[i].mask) == rtable[i].prefix && rtable[i].mask > rtable[idx].mask){
			idx = i;
		}
	}

	printf("%d\n", idx);
	if(idx == -1){
		return NULL;
	}

	else return (&rtable[idx]);
}

/*
 Returns a pointer (eg. &arp_table[i]) to the best matching ARP entry.
 for the given dest_ip or NULL if there is no matching entry.
*/
struct arp_entry *get_arp_entry(__u32 ip) {
	int i;

    for(i = 0; i < arp_table_len; i++){
    	if( arp_table[i].ip == ip){
    		return (&arp_table[i]);
    	}
    }

    return NULL;
}

int main(int argc, char *argv[])
{
	msg m;
	int rc, i;

	init();
	rtable = malloc(sizeof(struct route_table_entry) * 100);
	arp_table = malloc(sizeof(struct  arp_entry) * 100);
	DIE(rtable == NULL, "memory");
	rtable_size = read_rtable(rtable);
	parse_arp_table();
	/* Students will write code here */

	__u16 checksum;
	while (1) {
		rc = get_packet(&m);
		DIE(rc < 0, "get_message");
		struct ether_header *eth_hdr = (struct ether_header *)m.payload;
		struct iphdr *ip_hdr = (struct iphdr *)(m.payload + sizeof(struct ether_header));
		
		/* TODO 3: Check the checksum */
		checksum = ip_hdr->check;
		ip_hdr->check = 0;
		ip_hdr->check = ip_checksum(ip_hdr, sizeof(struct iphdr));
		printf("%d - %d\n", ip_hdr->check, checksum);

		if(checksum != ip_hdr->check){
			printf("Wrong check_sum, boy!\n");
			continue;
		}

		/* TODO 4: Check TTL >= 1 */
		if (ip_hdr->ttl < 1){
			printf("You are using too much bandwidth..\n");
			continue;
		}

		/* TODO 5: Find best matching route (using the function you wrote at TODO 1) */
		struct route_table_entry *route = get_best_route(ip_hdr->daddr);

		/* TODO 6: Update TTL and recalculate the checksum */
		ip_hdr->ttl--;
		ip_hdr->check = 0;
		ip_hdr->check = ip_checksum(ip_hdr, sizeof(struct iphdr));

		/* TODO 7: Find matching ARP entry and update Ethernet addresses */
		struct arp_entry *neighbour = get_arp_entry(route->next_hop);
		uint8_t smac[6];
		get_interface_mac(route->interface, smac);

		for(i = 0; i < 6; i++){
			eth_hdr->ether_dhost[i] = neighbour-> mac[i];
			eth_hdr->ether_shost[i] = smac[i];
		}
		
		/* TODO 8: Forward the pachet to best_route->interface */
		send_packet((route->interface), &m);
	}
}
