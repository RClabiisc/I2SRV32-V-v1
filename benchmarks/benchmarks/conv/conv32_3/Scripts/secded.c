#include<stdio.h>
#include <string.h>
 int paritycalc(int integer1[32],char line[40]);
FILE *fp1, *fp2;
int main() {
   
   char a;
   int i;
   char line[40];
   char hex[9];
   char p[60];
   int integer1[40];
   char binary[33]="";
   char hexbin[5]="";

   fp1 = fopen("code.hex", "r"); //32 bit file you need to read
   if (fp1 == NULL) {
      puts("cannot open this file");      
   }
 
   fp2 = fopen("code.bin", "w");  //39 bit coe file you obtain
   if (fp2 == NULL) {
      puts("Not able to open this file");
	}
	
	while( fgets(hex,10,fp1)!= NULL )
	{
		for(i=0;i<8;i++)
		{
			switch ( hex[i] ) {
			case '0':
				  hexbin[0]='0';hexbin[1]='0';hexbin[2]='0';hexbin[3]='0';		  
				  break;
			case '1':
				  hexbin[0]='0';hexbin[1]='0';hexbin[2]='0';hexbin[3]='1';		  
				  break;
			case '2':
				  hexbin[0]='0';hexbin[1]='0';hexbin[2]='1';hexbin[3]='0';		  
				  break;
			case '3':
				  hexbin[0]='0';hexbin[1]='0';hexbin[2]='1';hexbin[3]='1';		  
				  break;
			case '4':
				  hexbin[0]='0';hexbin[1]='1';hexbin[2]='0';hexbin[3]='0';		  
				  break;
			case '5':
				  hexbin[0]='0';hexbin[1]='1';hexbin[2]='0';hexbin[3]='1';		  
				  break;
			case '6':
				  hexbin[0]='0';hexbin[1]='1';hexbin[2]='1';hexbin[3]='0';		  
				  break;
			case '7':
				  hexbin[0]='0';hexbin[1]='1';hexbin[2]='1';hexbin[3]='1';		  
				  break;
			case '8':
				  hexbin[0]='1';hexbin[1]='0';hexbin[2]='0';hexbin[3]='0';		  
				  break;
			case '9':
				  hexbin[0]='1';hexbin[1]='0';hexbin[2]='0';hexbin[3]='1';		  
				  break;
			case 'A':
				  hexbin[0]='1';hexbin[1]='0';hexbin[2]='1';hexbin[3]='0';		  
				  break;
			case 'a':
				  hexbin[0]='1';hexbin[1]='0';hexbin[2]='1';hexbin[3]='0';		  
				  break;
			case 'B':
				  hexbin[0]='1';hexbin[1]='0';hexbin[2]='1';hexbin[3]='1';		  
				  break;
			case 'b':
				  hexbin[0]='1';hexbin[1]='0';hexbin[2]='1';hexbin[3]='1';		  
				  break;
			case 'C':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='0';hexbin[3]='0';		  
				  break;
			case 'c':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='0';hexbin[3]='0';		  
				  break;
			case 'D':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='0';hexbin[3]='1';		  
				  break;
			case 'd':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='0';hexbin[3]='1';		  
				  break;
			case 'E':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='1';hexbin[3]='0';		  
				  break;
			case 'e':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='1';hexbin[3]='0';		  
				  break;
			case 'F':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='1';hexbin[3]='1';		  
				  break;
			case 'f':
				  hexbin[0]='1';hexbin[1]='1';hexbin[2]='1';hexbin[3]='1';		  
				  break;
			default :
				  hexbin[0]='0';hexbin[1]='0';hexbin[2]='0';hexbin[3]='0';		  
				  break;	}

			strcat(binary,hexbin);	
		}
		fprintf(fp2,"%s\n",binary);
		for(i=0;i<33;i++)
		{	binary[i]='\0';}
	}
	      fclose(fp1);
	      fclose(fp2);


   fp1 = fopen("code.bin", "r"); //32 bit file you need to read
   if (fp1 == NULL) {
      puts("cannot open this file");      
   }
 
   fp2 = fopen("Outputfiles/secded.coe", "w");  //39 bit coe file you obtain
   if (fp2 == NULL) {
      puts("Not able to open this file");
      fclose(fp1);
     
   }
 fprintf(fp2,"%s;\n","MEMORY_INITIALIZATION_RADIX=2");
 fprintf(fp2,"%s\n","MEMORY_INITIALIZATION_VECTOR=");
 
char buffer[100];
//fgets(buffer, 100, fp1);
//fgets(buffer, 100, fp1);

while( fgets(line,40,fp1)!= NULL )
{

	for(i=0;i<32;i++)
	{	integer1[i]=(line[i]-'0');

	}

		paritycalc(integer1,line);
		//printf("\n");

}

fprintf(fp2,"000000000000000000000000000000000000000;");

   fcloseall();
   return 0;
}

int paritycalc(int integer1[32],char line[40])
{

int p0 = (integer1[31-0] ^ integer1[31-1]) ^ (integer1[31-3] ^ integer1[31-4]) ^ (integer1[31-6] ^ integer1[31-8]) ^ (integer1[31-10] ^ integer1[31-11]) ^ (integer1[31-13] ^ integer1[31-15]) ^ (integer1[31-17] ^ integer1[31-19]) ^ (integer1[31-21] ^ integer1[31-23]) ^ (integer1[31-25] ^ integer1[31-26]) ^ (integer1[31-28] ^ integer1[31-30]);

int p1 = (integer1[31-0] ^ integer1[31-2]) ^ (integer1[31-3] ^ integer1[31-5]) ^ (integer1[31-6] ^ integer1[31-9]) ^ (integer1[31-10] ^ integer1[31-12]) ^ (integer1[31-13] ^ integer1[31-16]) ^ (integer1[31-17] ^ integer1[31-20]) ^ (integer1[31-21] ^ integer1[31-24]) ^ (integer1[31-25] ^ integer1[31-27]) ^ (integer1[31-28] ^ integer1[31-31]);

int p2 = (integer1[31-1] ^ integer1[31-2]) ^ (integer1[31-3] ^ integer1[31-7]) ^ (integer1[31-8] ^ integer1[31-9]) ^ (integer1[31-10] ^ integer1[31-14]) ^  (integer1[31-15] ^ integer1[31-16]) ^ (integer1[31-17] ^ integer1[31-22]) ^ (integer1[31-23] ^ integer1[31-24]) ^ (integer1[31-25] ^ integer1[31-29]) ^ (integer1[31-30] ^ integer1[31-31]);

int p3 = (integer1[31-4] ^ integer1[31-5]) ^ (integer1[31-6] ^ integer1[31-7]) ^ (integer1[31-8] ^ integer1[31-9]) ^ (integer1[31-10] ^ integer1[31-18]) ^ (integer1[31-19] ^ integer1[31-20]) ^ (integer1[31-21] ^ integer1[31-22] ^ integer1[31-23]) ^ (integer1[31-24] ^ integer1[31-25]);

int p4 = (integer1[31-11] ^ integer1[31-12]) ^ (integer1[31-13] ^ integer1[31-14]) ^ (integer1[31-15] ^ integer1[31-16]) ^ (integer1[31-17] ^ integer1[31-18])^ (integer1[31-19] ^ integer1[31-20]) ^ (integer1[31-21] ^ integer1[31-22]) ^ (integer1[31-23] ^ integer1[31-24] ^ integer1[31-25]);

int p5 = (integer1[31-26] ^ integer1[31-27]) ^ (integer1[31-28] ^ integer1[31-29]) ^ (integer1[31-30] ^ integer1[31-31]);

int p6 = (integer1[31-31] ^ integer1[31-30] ^ integer1[31-29]^ integer1[31-28]) ^ (integer1[31-27] ^ integer1[31-26] ^ integer1[31-25] ^ integer1[31-24]) ^ (integer1[31-23] ^ integer1[31-22]) ^ (integer1[31-21] ^ integer1[31-20]) ^ (integer1[31-19] ^ integer1[31-18] ^ integer1[31-17] ^ integer1[31-16] ^ integer1[31-15] ^ integer1[31-14]) ^ (integer1[31-13] ^ integer1[31-12] ^ integer1[31-11] ^ integer1[31-10]) ^ (integer1[31-9] ^ integer1[31-8] ^ integer1[31-7] ^ integer1[31-6]) ^ (integer1[31-5] ^ integer1[31-4] ^ integer1[31-3] ^ integer1[31-2] ^ integer1[31-1] ^ integer1[31-0]) ^ (p0 ^ p1) ^ (p2 ^ p3) ^ (p4 ^ p5);	

char s0 = p0+'0';
char s1 = p1+'0';
char s2 = p2+'0';
char s3 = p3+'0';
char s4 = p4+'0';
char s5 = p5+'0';
char s6 = p6+'0';

char linewrite[40];

snprintf( linewrite, sizeof( linewrite ), "%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", s6,line[31-31],line[31-30],line[31-29],line[31-28],line[31-27],line[31-26],s5,line[31-25],line[31-24],line[31-23],line[31-22],line[31-21],line[31-20],line[31-19],line[31-18],line[31-17],line[31-16],line[31-15],line[31-14],line[31-13],line[31-12],line[31-11],s4,line[31-10],line[31-9],line[31-8],line[31-7],line[31-6],line[31-5],line[31-4],s3,line[31-3],line[31-2],line[31-1],s2,line[31-0],s1,s0 );


fprintf(fp2,"%s\n",strcat(linewrite,","));

//printf("%s\n",linewrite);
return 0;
}




