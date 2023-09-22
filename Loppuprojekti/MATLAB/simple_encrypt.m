% YKSINKERTAINEN STEGANOGRAFINEN SALAUS
% olettaa parametreina annettujen kuvien olevan samankokoiset

function im_encrypt = simple_encrypt(im1,im2)

    % tarkistetaan, että kuvat ovat samankokoiset
    msg_error = "Pictures are not same size!"; % varoitusteksti
    if (size(im2) ~= size(im2))
        % kuvat olivat erikokoiset
        error(msg_error) % virhe
    else
        % voidaan piilottaa kuva (im2) toiseen samankokoiseen kuvaan (im1)
        im_size = size(im1);
        im_encrypt = im1;
        for i = 1:im_size(1)
            for j = 1:im_size(2)
                for k = 1:im_size(3)
                    % käydään kummatkin kuvat pikseli pikseliltä 
                    % (sekä kaikki kolem RGB-väritasoa) 
                    % ja tallennetaan binäärilukuna
                    im1_pixel_binary = dec2bin(im1(i,j,k),8);
                    im2_pixel_binary = dec2bin(im2(i,j,k),8);
                    % valitaan kummastakin vain neljä merkitsevintä 
                    % eli ensimmäistä bittiä
                    s = im1_pixel_binary(1:4);
                    e = im2_pixel_binary(1:4);
                    % muodostetaan salatulle pikselille arvo yhdistämällä
                    % salattavan kuvan (im2) 4 bittiä
                    % toisen kuvan (im1) 4 bitin perään
                    new_pixel = bin2dec([s,e]);
                    % asetetaan saatu arvo salatun kuvan
                    % vastaavan pikselin arvoksi
                    im_encrypt(i,j,k) = new_pixel;
                end
            end
        end
    end
end
