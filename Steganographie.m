%Algorithme de Steganographie
clear all; 
close all;

%Lecture des deux images
Image1=imread('girlface.bmp');
Image2=rgb2gray(imread('pepper.bmp'));
[NL1,NC1]=size(Image1);
[NL2,NC2]=size(Image2);

% Initialisation d'une matrice de taille 512*512 à zéro.
Image_Extraite=zeros(512,512);

%Affichage de l'image originale
subplot(1,3,1);
imshow(uint8(Image2));
title('Image originale');

%On cache Image2 dans Image1
for i=1:NL1
    for j=1:NC1
        %On lit les bits de poids fort de "pepper"
        tab=dec2bin(Image2(i,j),8);
        poidsfort=tab(1:4);
        %Lire les bits de "girlface", remplacer ses bits de poids faible par les bits de poids fort de "pepper"
        tab=dec2bin(Image1(i,j),8);     
        tab(5:8)=poidsfort(1:4);
        % Convertir la nouvelle valeur en décimal et affecter au pixel sa nouvelle valeur
        x=bin2dec(tab);
        Image1(i,j)=x;   
    end
end

%On affiche l'image cachée
subplot(1,3,2);
imshow(uint8(Image1));
title('Image cachée');

%On extrait l'image caché dans Image1
for i=1:NL1
    for j=1:NC1
        %Lireles bits de "girlface" et prendre ses bits de poids faible (Qui sont les bits de poids fort de pepper)
        tab=dec2bin(Image1(i,j),8);
        poidsfort=tab(5:8);
        %Au bits de poids fort on rajoute les bits à valeur "0"
        tab(1:4)=poidsfort;
        tab(5:8)='0';
        %Convertir la valeur binaire en déciamle
        x=bin2dec(tab);
        Image_Extraite(i,j)=x;        
    end
end

%On affiche l'image extraite
subplot(1,3,3);
imshow(uint8(Image_Extraite));
title('Image extraite');


