Should be tested in Windows
Powershell software, WinGW are required.
UART Bridge drive is required.
Change the COM port name in uart_send.c file accordingly. From device manger, COM port is known.
In command prompt type pwsh to launch powershell
To compile the code command is 
    gcc -o .\demo.exe .\uart_send.c .\img.c .\expected_output.c

See DemoVideo for more details.
