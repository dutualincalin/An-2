#include <unistd.h>
#include <stdarg.h>			// Dutu Alin Calin
#include <string.h>			// 323 CD
#include <stdlib.h>

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

static char *unstochar(unsigned int value){
	unsigned int test = value;						// test - folosit pentru a afla marimea sirului final;
	int size = 0;									// size - marimea sirului final;

	while(test != 0){
		test /= 10;									// Se mareste size-ul cu numarul de cifre;
		size++;
	}

	char *str = malloc((size+1) * sizeof(char));		// Se aloca sirul str;
	for(int i = size - 1; value != 0; i--){
		str[i] = value % 10 + 48;					// Se ia fiecare rest al impartirii la 10 si se adauga in sir sub forma
		value /= 10;								// de caracter folosind codul ASCII (numar + 48 = char(numar));
	}												// Ordinea resturilor in sir este FILO;

	str[size] = '\0';								// Se inchide sirul cu caracterul nul;

	return str;										// Se returneaza sirul;
}

static char *inttochar(int value){
	int neg = 0, size = 0;							// neg - pentru a stii ca value e negativ; size - marimea sirului final;

	if(value < 0){									// Se verifica daca valoarea primita e negativa si in caz de adevar
		size++;										// se creste marimea pentru a adauga minusul in sir;
		neg = 1;									// Se memoreaza faptul ca valoarea este negativa
	}

	int test = value;								// test - folosit pentru a afla marimea sirului final;

	while(test != 0){								// Se mareste size-ul cu numarul de cifre;
		test /= 10;
		size++;
	}

	char *str = malloc((size + 1) * sizeof(char));	// Se aloca sirul str;

	for(int i = size - 1; value != 0; i--){			// Se ia fiecare rest al impartirii la 10 si se adauga in sir sub forma
		str[i] = abs(value % 10) + 48;				// de caracter folosind codul ASCII (numar + 48 = char(numar));
		value /= 10;								// Ordinea resturilor in sir este FILO
	}

	if(neg == 1)									// Afiseaza minusul la inceputul string-ului in cazul in care
		str[0] = '-';								// valoarea primita este negativa;

	str[size] = '\0';								// Se inchide sirul cu caracterul nul

	return str;										// Se returneaza sirul
}

static char *hextochar(unsigned int value){
	unsigned int test = value;						// test - folosit pentru a afla marimea sirului final;
	int size = 0, hv;								// size - marimea sirului final; hv - valoare ajutatoare (help value);

	while(test != 0){								// Se mareste size-ul cu numarul de resturi; 
		test /= 16;
		size++;
	}

	char *str = malloc((size+1) * sizeof(char));	// Se aloca sirul str;

	for(int i = size - 1; value != 0; i--){
		hv = value % 16;							// Se ia fiecare rest al impartirii la 16;

		if(hv < 10)									// Si se adauga in sir in functie de valoarea acestuia folosind codul ASCII
			str[i] = hv + 48;						// ( numar(< 10) + 48 = char(numar); numar(>= 10) + 87 = char(a/b/c/d/e/f));

		else str[i] = hv + 87;
		
		value /= 16;
	}

	str[size] = '\0';								// Se inchide sirul cu caracterul nul;

	return str;										// Se returneaza sirul final;
}

int iocla_printf(const char *format, ...){
	int length = 0;												// length - lungimea sirului final;
	int retval = 0, value;										// retval - returul functiei de scriere; value - pentru a extrage valori;
	char *point, *cvalue;										// point - pentru a parcurge format-ul; cvalue - value prelucrat in *char;
	char *copy = calloc(10000, sizeof(char));					// Alocarea copiei lui format;
	char *text = calloc(10000, sizeof(char));					// Alocarea sirului de afisat;

	va_list args;												// Declararea listei de argumente;
	va_start(args, format);										// Fixarea inceputului dupa format;

	strcpy(copy, format);										// Copierea lui format in copy si inchiderea string-ului;
	copy[strlen(format)] = '\0';

	for(point = copy; *point != '\0'; point++){					// Parcurgerea copiei formatului

		while(*point != '%' && *point != '\0'){
			text[length] = *point;								// In cazul in care nu se gasesc argumente,
			point++;											// se adauga textul propriu-zis in sir,
			length++;											// se trece la urmatorul element din sir
		}														// si crestem lungimea sirului final;

		if(*point == '%'){										// Daca se gasesc argumente care incep cu %
			point++;											// atunci se ia pe cazuri;

			switch(*point){
				case '%':
					text[length] = '%';							// %% = Se adauga un % in sirul final;
					length += 1;								// Crestem lungimea sirului final;
					break;
			

				case 'd':
					value = va_arg(args,int);					// %d = Se citeste valoarea si se transforma in sir
					cvalue = inttochar(value);					// de caractere folosind functia inttochar;

					strcat(text,cvalue);						// Sirul obtinut(cvalue) se concateneaza cu sirul final;
					length += strlen(cvalue);					// Se creste lungimea lui text cu lungimea lui cvalue;

					free(cvalue);								// Fiind alocat in functie, cvalue trebuie dealocat;
					break;
			

				case 'u' :
					value = va_arg(args,unsigned int);			// %u = Se citeste valoarea si se transforma in sir
					cvalue = unstochar(value);					// de caractere folosind functia unstochar;

					strcat(text,cvalue);						// Sirul obtinut se concateneaza cu sirul final;
					length += strlen(cvalue);					// Se creste lungimea lui text cu lungimea lui cvalue;

					free(cvalue);								// Se dealoca cvalue;
					break;
			

				case 'x' :
					value = va_arg(args,unsigned int);			// %d = Se citeste valoarea si se transforma in sir
					cvalue = hextochar(value);					// de caractere folosind functia hextochar;

					strcat(text,cvalue);						// Sirul obtinut se concateneaza cu sirul final;
					length += strlen(cvalue);					// Creste lungimea lui text cu lungimea lui cvalue;

					free(cvalue);								// Se dealoca cvalue;
					break;
			

				case 'c' :
					text[length] = va_arg(args,int);			// %c = se adauga pur si simplu caracterul in sir
					length += 1;								// si se actualizeaza lungimea sirului final;
					break;
			

				case 's' :
					cvalue = va_arg(args, char*);				// %s = se pointeaza catre sirul de caractere

					strcat(text,cvalue);						// se adauga in sirul text
					length += strlen(cvalue);					// si se actualizeaza lungimea sirului final;
					break;
			}
		}

		else 
			if(*point == 92){									// In cazul in care avem "\\" -> escaping...
				point++;

				switch(*point){
					case '\n' :
						text[length] = 92;						// Pur si simplu afisam componentele
						text[length + 1] = 'n';					// caracterului bucata cu bucata si
						length += 2;							// actualizam lungimea sirului final;
						break;

					case '\t' :
						text[length] = 92;
						text[length + 1] = 't';					// Si aici procedam similar;
						length += 2;
						break;
			}
		}
	}

	va_end(args);												// Inchidem lista cu argumente;

	text[length] = '\0';										// Inchidem sirul final;
	retval += write_stdout(text,length);						// Afisam sirul final si returnam

	return retval;												// valoarea primita de functia write_stdout
}
