 % YKSINKERTAISEN STEGANOGRAFISEN SALAUKSEN PURKU
 % olettaa parametrina annetun kuvan olevan salattu 
 % käyttäen funktiota simple_encrypt

function im_decrypt = simple_decrypt(im)
    im_size = size(im);
    im_decrypt = im;
    for i = 1:im_size(1)
        for j = 1:im_size(2)
            for k = 1:im_size(3)
                % käydään kuva pikseli pikseliltä 
                % (sekä kaikki kolem RGB-väritasoa) 
                % ja tallennetaan binäärilukuna
                im_pixel_binary = dec2bin(im(i,j,k),8);
                % valitaan neljä viimeisintä bittiä, 
                % joihin salatun kuvan neljä merkitsevintä bittiä 
                % tiedetään olevan piilotettuna
                s = im_pixel_binary(5:8);
                % tieto neljän viimeisen bitin arvoista ei välity
                % tällä simppelillä salauksella, 
                % joten asetetaan ne nolliksi ja yhdistetään
                e = '0000';
                new_pixel = bin2dec([s,e]);
                % asetetaan saatu arvo puretun kuvan 
                % vastaavan pikselin arvoksi
                im_decrypt(i,j,k) = new_pixel;
            end
        end
    end
end