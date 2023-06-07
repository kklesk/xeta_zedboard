//
// Created by klesk on 05.06.23.
//

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>

#ifdef SOFTWARE
#include "xeta.h"
#include <string.h>
#endif

#define PAGESIZE 4096
#define BASE_ADDRESS 0x43C00000

/* TODO
//Function:  DWord2Hex
//Converts a dword containted in a LSL integer to hexadecimal format.
string DWord2Hex(integer m){

    string result;
    integer i = 0;
    integer index = 0;

    //Define character string [0-F] for use in building the hex.
    string characters = "0123456789ABCDEF";

    //Step through 8 times, for a total of 32 bits, 8 nibbles, and 8 hexadecimal digits.
    for (i = 0; i < 8; i++){
        //Get a nibble by right-shifting and masking off 4 bits.
        index  = (m >> (i * 4)) & 0xF;
        //Grab character from the characters string at index position and add it to the result string.
        result = llInsertString(result, 0, llGetSubString(characters,index,index));
    }

    return result;
}
*/

int main(int argc, char **argv){

    //TODO read arguments and parse in hex
    if(argc <= 1 )
        exit(-1);
    /*Create char array
     * 0x4161 = Aa
     * 0x6242 = bB
     * */
//    u_int32_t  words[] = {(u_int32_t) "AA"};
    u_int32_t words[] = { 0x4161 , 0x6242};


    int fd = open("/dev/mem", O_RDWR | O_SYNC, S_IRWXU);
    if (fd == -1){
        perror("Error while read device /dev/mem");
        exit -1;
    }
    int* pBaseAddress =(int* ) mmap(NULL,PAGESIZE,PROT_READ|PROT_WRITE, MAP_SHARED, fd,BASE_ADDRESS);
    if (pBaseAddress == NULL){
        perror("Error while mmap on BaseAddress");
        exit -1;
    }
    /* VHDL Addresses/Ports
     * Baseaddress + 0 : String one
     * Baseaddress + 1 : String one
     * Insert Aa in Port_1
     * Insert bB in Port_2
     * */

    /*set words into port_1 and port_2*/
    *(pBaseAddress + 0 ) = words[0];
    *(pBaseAddress + 1 ) = words[1];

    printf("")

    close(fd);
    munmap(pBaseAddress,getpagesize());
    return 1;
/* Get all relevant vars*/
#ifdef DEBUG
    for (int i = 0; i< argc; i ++ ){
        printf("argc[%d]: argv = %s\n",i,argv[i]);
    }
    printf("\n");
    //    printf("sizeof(argv[1])= %d\n",sizeof(argv[1])/sizeof (uint32_t));
    //    uint32_t* word = malloc(sizeof (*argv)); //= (uint32_t *) (uint32_t) argv[1];
    //    strncpy( (uint32_t*)word,argv[1],3);
    //    for(int i = 0; i < sizeof(word)/2; i++){
    //        //uint32_t words[0] = (uint32_t *) word[i];
    //    }
#endif

/* For Algorithm via software*/
#ifdef SOFTWARE
//    uint32_t key[] = { 0x1337, 0x3317, 0x3137, 0x1733};
    uint32_t key[] = {0x61610a,0x9E3798,0x9E3776,0x9E3773};

    uint32_t words [] = { 0x4161 , 0x6141};
    uint32_t* v_new_encipher = encipher(2, words,  key);
    uint32_t* v_new_decipher = decipher(2, v_new_encipher,  key);

    for (int i = 0; i < 2 ; i ++){
        printf("v_new_encipher: %c\n",v_new_encipher[i]);
        printf("v_new_decipher: %c\n",v_new_decipher[i]);
    }
#endif

}