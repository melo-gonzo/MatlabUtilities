function close_serial_ports()
p=instrfind;
if sum(size(p))>0
    fclose(p);
    delete(p);
    clear p
end
disp('closed serial ports')