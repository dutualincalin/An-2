// Nume: Dutu Alin Calin
// Grupa: 323 CD

#include <queue.h>
#include "skel.h"

// Algoritm de citire a tabelei de rutare.
route_table *read_route_table(FILE *file){
	struct in_addr adress;
	int interface, rc;
	char *str1, *str2, *str3;

	// Alocarea tabelei de rutare.
	route_table *table = (route_table*) malloc(sizeof(route_table));
	table->routes = (route_table_line**) malloc(1000000 * sizeof(route_table_line*));
	table->size = 0;

	str1 = (char*) malloc(32 * sizeof(char));
	str2 = (char*) malloc(32 * sizeof(char));
	str3 = (char*) malloc(32 * sizeof(char));

	// Citirea fiecarei linii a tabelei de rutare din fisierul de intrare.
	while(!feof(file)){
		table->routes[table->size] = (route_table_line*) malloc(sizeof(route_table_line));
		fscanf(file,"%s %s %s %d", str1, str2, str3, &interface);

		inet_aton(str1, &adress);
		DIE(rc < 0, "inet_aton failure...Unacceptable!");
		table->routes[table->size]->prefix = adress.s_addr;

		inet_aton(str2, &adress);
		DIE(rc < 0, "inet_aton failure...Unacceptable!");
		table->routes[table->size]->next_hop = adress.s_addr;

		rc = inet_aton(str3, &adress);
		DIE(rc < 0, "inet_aton failure...Unacceptable!");
		table->routes[table->size]->mask = adress.s_addr;

		table->routes[table->size]->interface = interface;
		table->size++;
	}

	free(str1);
	free(str2);
	free(str3);

	return table;
}

// Algoritm de sortare prin imbinare.
void merger(route_table *table, int start, int mid, int end){
	int i, j, k;
	int sizel = mid - start + 1;
	int sizer = end - mid;

	route_table_line **routel = (route_table_line **)malloc(sizel * sizeof(route_table_line *));
	route_table_line **router = (route_table_line **)malloc(sizer * sizeof(route_table_line *));

	// Umplerea celor doi vectori auxiliari.
	for(i = 0; i < sizel; i++){
		routel[i] = table->routes[start + i];
	}

	for(i = 0; i < sizer; i++){
		router[i] = table->routes[mid + 1 + i];
	}

	i = 0; j = 0; k = start;

	// Sortarea elementelor si adaugarea lor in tabel.
	while (i < sizel && j < sizer){
		if(ntohl(routel[i]->prefix) < ntohl(router[j]->prefix)){
			table->routes[k] = routel[i];
			i++;
		}

		else{
			table->routes[k] = router[j];
			j++;
		}

		k++;
	}

	while(i < sizel){
		table->routes[k] = routel[i];
		i++;
		k++;
	}

	while(j < sizer){
		table->routes[k] = router[j];
		j++;
		k++;
	}

	free(routel);
	free(router);
}

// Functie de pornire a Merge Srot-ului pentru tabela de rutare.
void sort_table(route_table *table, int start, int end){
	if(start < end){
		int mid = start + (end - start)/2;

		sort_table(table, start, mid);
		sort_table(table, mid + 1, end);

		merger(table, start, mid, end);
	}
}


// Algoritm de cautare binara a celei mai bune potriviri
int route_finder(route_table *table, uint32_t ip, int start, int end){
	if(start <= end){
		int middle = (start + end) / 2;

		// In caz de potrivire se returneaza elementul din mijloc.
		if((ip & table->routes[middle]->mask) == table->routes[middle]->prefix){
			return middle;
		}
		
		// In functie de prefix se returneaza rezultatul din partea stanga...
		if(ntohl(ip & table->routes[middle]->mask) < ntohl(table->routes[middle]->prefix)) {
			return route_finder(table, ip, 0, middle - 1);
		}

		// respectiv partea dreapta a tabelei de rutare.
		return route_finder(table, ip, middle + 1, end);
	}

	else return -1;
}

// Functia creeaza o tabela arp dinamica goala.
arp_table *get_arp_table(){
	arp_table *table = (arp_table*) malloc (sizeof(arp_table));
	table->arps = (arp_table_line**) malloc (50000 * sizeof(arp_table_line*));
	table->size = 0;
	return table;
}

// Functia adauga o noua linie in tabela arp
void add_arp_entry(arp_table *table, uint32_t ip, uint8_t *mac){
	arp_table_line *line = (arp_table_line*)malloc(sizeof(arp_table_line));

	// Popularea noii linii de tabela
	line->ip = ip;
	line->mac = malloc(ETH_ALEN * sizeof(uint16_t));
	memcpy(line->mac, mac, ETH_ALEN);

	// Adaugarea liniei si incrementarea marimii tabelului
	table->arps[table->size] = line;
	table->size++;
}

// Functia gaseste adresa mac corespunzatoare ip-ului dat ca parametru.
arp_table_line *arp_mac_finder(arp_table *table, uint32_t ip){
	int i;

	// Se itereaza pana cand se gaseste linia cautata sau se returneaza NULL.
	for(i = 0; i < table->size; i++){
		if(table->arps[i]->ip == ip){
			return table->arps[i];
		}
	}

	return NULL;
}

// Functia verifica daca adresa ip se afla printre adresele ip ale router-ului.
int destination_router_ip(uint32_t *r_ips, uint32_t ip){
	// Se itereaza prin toate adresele ip ale router-ului pana cand se gaseste
	// o potrivire sau se va returna -1.
	for(int i = 0; i < ROUTER_NUM_INTERFACES; i++){
		if(r_ips[i] == ip){
			return i;
		}
	}

	return -1;
}

int main(int argc, char *argv[]){
	packet m, m_copy;

	// Se creaza un queue pentru ARP Request.
	queue arp_queue = queue_create();

	FILE *file = fopen(argv[1], "r");
	DIE(file == NULL, "Route table file not found...abort the mission");

	// Se initalizeaza si sorteaza tabela de rutare
	route_table *route_table = read_route_table(file);
	sort_table(route_table, 0, route_table->size - 1);
	route_table_line *best_route = NULL;

	fclose(file);

	// Se initializeaza tabela arp
	arp_table *arp_table = get_arp_table();
	arp_table_line *best_mac = NULL;

	init(argc - 2, argv + 2);

	int rc, i, best, interface;
	struct in_addr interf_addr;
	uint16_t ip_check;

	// Alocarea vectorilor pentru adresele ip si mac ale ruter-ului.
	uint8_t **r_macs = (uint8_t**) malloc(ROUTER_NUM_INTERFACES * sizeof(uint8_t*));
	uint32_t *r_ips = (uint32_t*) malloc(ROUTER_NUM_INTERFACES * sizeof(uint32_t));

	// Popularea vectorilor pentru adresele ip si mac ale ruter-ului.
	for(i = 0; i < ROUTER_NUM_INTERFACES; i++){
		rc = inet_aton(get_interface_ip(i), &interf_addr);
		DIE(rc < 0, "inet_aton failure...Unacceptable!");
		r_ips[i] = interf_addr.s_addr;

		r_macs[i] = malloc(ETH_ALEN * sizeof(uint8_t));
		get_interface_mac(i, r_macs[i]);
	}

	while (1) {
		rc = get_packet(&m);
		DIE(rc < 0, "Your packets is long gone!");

		struct ether_header *eth_hdr = (struct ether_header *)m.payload;
		struct arp_header *arp_hdr = parse_arp(m.payload);
		struct iphdr *ip_hdr = (struct iphdr *)(m.payload + sizeof(struct ether_header));
		struct icmphdr *icmp_hdr = parse_icmp(m.payload);
		
		// ICMP-echo catre router
		if(icmp_hdr != NULL){
			interface = destination_router_ip(r_ips, ip_hdr->daddr);

			// Se verifica daca pachetul ICMP are ca adresa destiantie una din adresele ruter-ului.
			if(interface != -1){
				// Daca pachetul este de tip Echo Request
				if(icmp_hdr->type == 8){
					send_icmp( ip_hdr->saddr, ip_hdr->daddr, eth_hdr->ether_dhost, eth_hdr->ether_shost, 0, 0, interface, icmp_hdr->un.echo.id, icmp_hdr->un.echo.sequence);
					continue;
				}

				else continue;
			}
		}

		// Daca este pachet ARP
		if(arp_hdr != NULL) {
			// Daca este pachet ARP request
			if(ntohs(arp_hdr->op) == ARPOP_REQUEST){
				interface = destination_router_ip(r_ips, arp_hdr->tpa);

				// Daca pachetul este destinat unei adrese a ruter-ului
				if(interface != -1){
					// Se trimite un arp reply cu adresa mac corespunzatoare.
					build_ethhdr(eth_hdr, r_macs[interface], eth_hdr->ether_shost, eth_hdr->ether_type);
					send_arp(arp_hdr->spa, r_ips[interface], eth_hdr, m.interface, htons(2));
					continue;
				}
			}

			// Daca este pachet ARP reply
			if(ntohs(arp_hdr->op) == ARPOP_REPLY){
				// Se adauga adresa cautata in tabela arp
				add_arp_entry(arp_table, arp_hdr->spa, eth_hdr->ether_shost);

				// Se verifica daca exista pachete de trimis/
				if(queue_empty(arp_queue) == 0){
					packet m_waiting = *(packet *)queue_deq(arp_queue);

					struct ether_header *eth_hdr_waiting = (struct ether_header *)m_waiting.payload;
					struct iphdr *ip_hdr_waiting = (struct iphdr *)(m_waiting.payload + sizeof(struct ether_header));

					// Se cauta ruta potrivita pentru pachetul din queue.
					best = route_finder(route_table, ip_hdr_waiting->daddr, 0, route_table->size - 1);

					// Se modifica header-ul ethernet si se trimite pachetul.
					best_route = route_table->routes[best];
					m_waiting.interface = best_route->interface;
	            	build_ethhdr(eth_hdr_waiting, r_macs[best_route->interface], eth_hdr->ether_shost, htons(2048));
					send_packet(best_route->interface, &m_waiting);
				}
			}

			continue;
		}
		
		// ttl <= 1
		// Se trimite un ICMP de Time Exceeded daca ttl e mai mic decat 1
		if(ip_hdr->ttl <= 1){
			send_icmp_error(ip_hdr->saddr, r_ips[m.interface], r_macs[m.interface], eth_hdr->ether_shost, 11, 0, m.interface);
			continue;
		}

		// Checksum gresit?
		// Se arunca pachetul daca checksum e gresit.
		ip_check = ip_hdr->check;
		ip_hdr->check = 0;
		ip_hdr->check = ip_checksum(ip_hdr, sizeof(struct iphdr));

		if(ip_check != ip_hdr->check){
			continue;
		}

		// ttl -- , update checksum
		ip_hdr->ttl--;
		ip_hdr->check = 0;
		ip_hdr->check = ip_checksum(ip_hdr, sizeof(struct iphdr));
		
		// Se cauta intrarea cea mai specifica din tabelul de rutare
		best = route_finder(route_table, ip_hdr->daddr, 0, route_table->size - 2);

		// Cazul in care nu se gaseste ruta cea mai buna
		if(best == -1){
			send_icmp_error(ip_hdr->saddr, r_ips[m.interface], eth_hdr->ether_dhost, eth_hdr->ether_shost, 3, 0, m.interface);
			continue;
		}

		else best_route = route_table->routes[best];
		
		// Se cauta adresa mac a urmatoarei destinatii.
		best_mac = arp_mac_finder(arp_table, best_route->next_hop);

		// Trimiterea pachetelor
		// Daca nu se gaseste adresa MAC
		if(best_mac == NULL){
			// Se adauga in ETHERNET in destinatie o adresa broadcast.
            eth_hdr->ether_type = htons(ETHERTYPE_ARP);
            get_interface_mac(best_route->interface, eth_hdr->ether_shost);
            memset(eth_hdr->ether_dhost, 255, 6);
			
			// Se face o copie a pachetului original care va fi pusa in coada de asteptare.
			m_copy = m;
			queue_enq(arp_queue, &m_copy);

			// Se trimite ARP Request-ul pentru pachetul din coada.
			send_arp(best_route->next_hop, r_ips[best_route->interface], eth_hdr, best_route->interface, htons(1));
			continue;
		}

		else {
			// Se adauga in protocolul Ethernet adresele corespunzatoare si se trimite pachetul.
			m.interface = best_route->interface;
            build_ethhdr(eth_hdr, r_macs[best_route->interface], best_mac->mac, htons(ETHERTYPE_IP));
			send_packet(best_route->interface, &m);
			continue;
		}
	}
}
