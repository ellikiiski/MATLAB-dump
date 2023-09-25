%% PROJEKTITYÖ - STEGANOGRAFIA
% Valokuvan matematiikka 2023
% Elli Kiiski
%
% LISÄÄ KUVAUS!!
%
% Tämä skripti ja siihen liittyvä raportti löytyvät osoitteesta
% https://github.com/ellikiiski/Valokuvan-matematiikka-2023/tree/main/Loppuprojekti

close all;
clear all;

%% YKSINKERTAINEN KUVAN PIILOTUS TOISEEN KUVAAN
% tietoa häviää sekä peitteenä käytettävästä kuvasta
% että piilotettavasta kuvasta,
% eikä salattu kuva piilota kaikkea tietoa edes paljaalla silmältä

% luetaan kuvat
im1 = imread("kuvat/working-hard.jpg"); % kuva, johon piilotetaan
im2 = imread("kuvat/sillis-chilli.jpg"); % piilotettava kuva

% SALAUS
% verrataan alkuperäistä kuvaa (im1)
% ja piilotetun kuvan (im2) sisältävää kuvaa
% sekä niiden erotusta
simple_e = simple_encrypt(im1,im2); % piilotettu kuva
diff_simple_e = rescale(double(im1)-double(simple_e)); % erotuskuva
figure
subplot(1,3,1)
imshow(im1)
title("Alkuperäinen kuva")
subplot(1,3,2)
imshow(simple_e)
title("Sisältää toisen kuvan")
subplot(1,3,3)
imshow(diff_simple_e)
title("Kuvien erotus")

% SALAUKSEN PURKU
% verrataan alkuperäistä kuvaa (im2)
% ja salatusta kuvasta purettua kuvaa
% sekä niiden erotusta
simple_d = simple_decrypt(simple_e); % purettu salatusta kuvasta
diff_simple_d = rescale(double(im2)-double(simple_d)); % erotuskuva
figure
subplot(1,3,1)
imshow(im2)
title("Alkuperäinen kuva")
subplot(1,3,2)
imshow(simple_d)
title("Salattu ja purettu kuva")
subplot(1,3,3)
imshow(diff_simple_d)
title("Kuvien erotus")

%% BITIT SEKOITTAVAT SALAUKSET

% komplementtimetodi
complemnt_e = complement_encrypt(im1,im2); % piilotettu kuva
diff_comp_e = rescale(double(im1)-double(complemnt_e)); % erotuskuva
% käänteismetodi
reverse_e = reverse_encrypt(im1,im2); % piilotettu kuva
diff_rev_e = rescale(double(im1)-double(reverse_e)); % erotuskuva
figure
subplot(2,2,1)
imshow(complemnt_e)
title("Komplementtimetodilla salattu kuva")
subplot(2,2,2)
imshow(diff_comp_e)
title("Komplemettimetodin erotus alkuperäiseen")
subplot(2,2,3)
imshow(reverse_e)
title("Käänteisellä metodilla salattu kuva")
subplot(2,2,4)
imshow(diff_rev_e)
title("Käänteisen metodin erotus alkuperäiseen")