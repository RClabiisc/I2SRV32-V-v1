//
// serial.c / serial.cpp
// A simple serial port writing example
// Written by Ted Burke - last updated 13-2-2013
//
// To compile with MinGW:
//
//      gcc -o serial.exe serial.c
//
// To compile with cl, the Microsoft compiler:
//
//      cl serial.cpp
//
// To run:
//
//      serial.exe
//
 
#include <windows.h>
#include <stdio.h>
#include <stdint.h>
 #include "header.h"
int main()
{
    ///////////////////
    // User Interface
       printf("********************WELCOME************************\n");
    printf("*HANDWRITTIN DIGIT RECOGNITION ON RISCV Vector CPU*\n");
    printf("*MTech Project  2021                              *\n");
    printf("*Developed by : V Naveen Chander                  *\n");
    printf("***************************************************\n");
    printf("*                   INSTRUCTIONS                  *\n");
    printf("* Select any Image out of 100 images              *\n");
    printf("* ------------------------------------------------*\n");
    printf("*                                                 *\n");
    printf("*                                                 *\n");


    int image_id;
    char msg[784];
    // SELF TEST : Automatically verify output for all images
    #ifdef SELF_TEST
        char classified;
        int error_count = 0;
        for (int i=0; i<100; i++)
        {
            classified  = uart_send(img[i]);
            if(classified != (char )(expected_output[i] + 48) )
            {
                error_count++;
                printf("Failed at %d : Expected = %d  : Classified = %c\n",i, expected_output[i], classified);
            }
            else
                printf("Success at %d : Expected = %d  : Classified = %c\n",i, expected_output[i], classified);
        }
        printf("SELF TEST COMPLETED. No. of Errors = %d\n", error_count);
    #else
    while(1)
    {
        char classified;
        printf("* Enter a number between 0 to 99                  *\n");
        scanf("%d",&image_id);
        if ((image_id>=0) || (image_id<100))
        {
            printf("The Image Number entered is :%d\n",image_id);
            // Store the requd input image into msg
            for (int idx=0;idx<784;idx++)
                msg[idx]=img[image_id][idx];

            classified = uart_send(msg);
            
            printf("* ------------------------------------------------*\n");
            printf("* Expected Ouput : %d                             *\n",expected_output[image_id]);
            printf("* Classified     : %c                             *\n",classified);
            printf("* ------------------------------------------------*\n");
            printf("*                                                 *\n");

        }          
        else
        {
            printf("Error: Enter number between 0 and 99\n");
        }
    } 
    #endif     
    return 0;
}

char uart_send(char img[784])
{
    char img_header[4];
    img_header[0] = 0xAA;
    img_header[1] = 0x55;
    img_header[2] = 0xBB;
    img_header[3] = 0x66;
    char readByte;
 
    // Declare variables and structures
    HANDLE hSerial;
    DCB dcbSerialParams = {0};
    COMMTIMEOUTS timeouts = {0};
    // Open the highest available serial port number
   //  fprintf(stderr, "Opening serial port...");
    hSerial = CreateFile(
                "\\\\.\\COM2", GENERIC_READ|GENERIC_WRITE, 0, NULL,
                OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL );
    if (hSerial == INVALID_HANDLE_VALUE)
    {
            fprintf(stderr, "Error\n");
            return 1;
    }
   // else fprintf(stderr, "OK\n");
     
    // Set device parameters (38400 baud, 1 start bit,
    // 1 stop bit, no parity)
    dcbSerialParams.DCBlength = sizeof(dcbSerialParams);
    if (GetCommState(hSerial, &dcbSerialParams) == 0)
    {
        fprintf(stderr, "Error getting device state\n");
        CloseHandle(hSerial);
        return 1;
    }
     
    dcbSerialParams.BaudRate = CBR_57600;
    dcbSerialParams.ByteSize = 8;
    dcbSerialParams.StopBits = ONESTOPBIT;
    dcbSerialParams.Parity = NOPARITY;
    if(SetCommState(hSerial, &dcbSerialParams) == 0)
    {
        fprintf(stderr, "Error setting device parameters\n");
        CloseHandle(hSerial);
        return 1;
    }
 
    // Set COM port timeout settings
    timeouts.ReadIntervalTimeout = 50;
    timeouts.ReadTotalTimeoutConstant = 50;
    timeouts.ReadTotalTimeoutMultiplier = 10;
    timeouts.WriteTotalTimeoutConstant = 50;
    timeouts.WriteTotalTimeoutMultiplier = 10;
    if(SetCommTimeouts(hSerial, &timeouts) == 0)
    {
        fprintf(stderr, "Error setting timeouts\n");
        CloseHandle(hSerial);
        return 1;
    }
 
    // Send specified text (remaining command line arguments)
    DWORD bytes_written;
   // fprintf(stderr, "Sending bytes...");
    FILE *logfile;
    logfile = fopen("logfile.txt","w+");
    // Send Header
        if(!WriteFile(hSerial, img_header, sizeof(img_header), &bytes_written, NULL))
        {
            fprintf(stderr, "Error\n");
            CloseHandle(hSerial);
            return 1;
        }   
       // fprintf(stderr, "Image Header : %d bytes written ....\n", (int )bytes_written);  
     //Read back Header
        DWORD bytesRead; 
        char buffer[4];
        char rd_buffer[800];
        //fprintf(logfile,"Reading Header ...\n");
        //printf("Reading Header ...\n");
        BOOL bOk = ReadFile(hSerial, buffer, sizeof(buffer) , &bytesRead, NULL);
        if (bOk && (bytesRead > 0)) {
            //for(int idx=0; idx < sizeof(buffer) ; idx++)
               // fprintf(logfile, "Header Read Value[%d] :%x\n",idx,(uint8_t )buffer[idx]);
                //printf("Header Read Value[%d] :%x\n",idx,(uint8_t )buffer[idx]);
        }
        else
            fprintf(stderr,"bOk = %d : bytesRead = %d\n",(int )bOk, (int )bytesRead);    
    #ifdef DEBUG
    for(int count=0;count <784;count++){
        if(!WriteFile(hSerial, &img[count], 1, &bytes_written, NULL))
        {
            fprintf(stderr, "Error\n");
            CloseHandle(hSerial);
            return 1;
        }   

       // fprintf(stderr, "%d bytes written ....\n", (int )bytes_written);
        //Read from Serial Port
         bOk = ReadFile(hSerial, &readByte, 1, &bytesRead, NULL);
        if (bOk && (bytesRead > 0)) {
            fprintf(logfile, "READ Value[%d] :%4x\n",count,readByte);
        }
        else
            fprintf(stderr,"bOk = %d : bytesRead = %d\n",(int )bOk, (int )bytesRead);
        
    }
    #else
        if(!WriteFile(hSerial, img, 784, &bytes_written, NULL))
        {
            fprintf(stderr, "Error\n");
            CloseHandle(hSerial);
            return 1;
        }   
        //Read from Serial Port
         bOk = ReadFile(hSerial, rd_buffer, 784, &bytesRead, NULL);
        if (bOk && (bytesRead > 0)) {
            //fprintf(logfile, "READ Success\n");
            //printf("READ Success\n");
            //printf("BYtes Read : %d\n",(int )bytesRead);
        }
        else
            fprintf(stderr,"bOk = %d : bytesRead = %d\n",(int )bOk, (int )bytesRead);
        
    #endif 

    // Read Result//////////////
     bOk = ReadFile(hSerial, &readByte, 1, &bytesRead, NULL);
        if (bOk && (bytesRead > 0)) {
           // printf("Image CLassified as :%c\n",readByte);
        }
        else
            fprintf(stderr,"OUtput Not Received \n .bOk = %d : bytesRead = %d\n",(int )bOk, (int )bytesRead);
    // Close serial port
    //fprintf(stderr, "Closing serial port...");
    if (CloseHandle(hSerial) == 0)
    {
        fprintf(stderr, "Error\n");
        return 1;
    }
    //fprintf(stderr, "OK\n");
 
    // exit normally
    fclose(logfile);
    return readByte;
}