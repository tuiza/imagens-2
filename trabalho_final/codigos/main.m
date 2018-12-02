%%
% TRABALHO FINAL DE IMAGENS 2 - PORTIFÓLIO
% Autor: Paulo Camargos Silva (https://github.com/PauloCamargos)
% Data: 0/12/2013
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pkg load image
clear; clc;

% Leitura das imagens
imagens = {
    imread('../imagens-base/PauloCamargos_RM pescoco4.jpg');
    imread('../imagens-base/PauloCamargos_RMabdomen.jpg');
    };

% executando as func�es
% brilho_contraste(imagens);
% equalizacao(imagens);
% transformacao_intensidade(imagens);
% filtro_suavizacao(imagens);
filtro_espacial(imagens);

close all;
clear, clc;

function brilho_contraste(imagens)

% Fatores de soma/multiplicacao: [+bri, -bri, +cont, -cont]
fatores = [100, 100, 1.5, 0.7];

% Medias
% 2 imagens, 5 resultados {original, +brilho, -brilho, +cont, -cont}
medias = zeros(2,5);

% Titulos para os graficos
titulos = {'Original', 'Mais Brilho', 'Menos Brilho', 'Mais Contraste', 'Menos Contraste'};

% Para cada imagem, faca
for i=1:2
    % Alteracoes de propriedade das imagens: Brilho e contraste
    % Aumentando o brilho
    imagens{i,2} = imagens{i} + fatores(1); % +Brilho
    % Diminuindo o brilho
    imagens{i,3} = imagens{i} - fatores(2); % -Brilho
    % Aumentando o contraste
    imagens{i,4} = imagens{i} * fatores(3); % +Cont
    % Diminuindo o contraste
    imagens{i,5} = imagens{i} * fatores(4); % -Cont
    
    % Calculo de media
    medias(i,1) = mean(imagens{i,1}(:)); % Original
    medias(i,2) = mean(imagens{i,2}(:)); % +brilho
    medias(i,3) = mean(imagens{i,3}(:)); % -brilho
    medias(i,4) = mean(imagens{i,4}(:)); % +cont
    medias(i,5) = mean(imagens{i,5}(:)); % -cont
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Brilho
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figura_brilho = figure;
    subplot(2,3,1);
    imshow(uint8(imagens{i,1})); % img original
    titulo = horzcat(titulos{1,1},sprintf(" med = %d",round(medias(i,1))));
    title(titulo)
    
    subplot(2,3,4);
    imhist(uint8(imagens{i,1})); % hist img original
    title(horzcat('Hist. ', titulos{1,1}));
    
    %%%%%%%% mais brilho
    subplot(2,3,2);
    imshow(uint8(imagens{i,2})); % mais brilho
    titulo = horzcat(titulos{1,1},sprintf(" med = %d",round(medias(i,2))));
    title(titulo)
    
    subplot(2,3,5);
    imhist(uint8(imagens{i,2})); % hist mais brilho
    title(horzcat('Hist. ', titulos{1,2}));
    
    %%%%%%% menos brilho
    subplot(2,3,3);
    imshow(uint8(imagens{i,3})); % img menos brilho
    titulo = horzcat(titulos{1,1},sprintf(" med = %d",round(medias(i,3))));
    title(titulo)
    
    subplot(2,3,6);
    imhist(uint8(imagens{i,3})); % hist img menos brilho
    title(horzcat('Hist. ', titulos{1,3}));
    
    filename = horzcat(sprintf('../resultados/brilho_contraste/brilho-im-%i',i),'.png');
    disp(filename)
    saveas(figura_brilho,filename);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Contraste
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figura_constraste = figure;
    subplot(2,3,1);
    imshow(uint8(imagens{i,1})); % img original
    titulo = horzcat(titulos{1,1},sprintf(" med = %d",round(medias(i,1))));
    title(titulo)
    
    subplot(2,3,4);
    imhist(uint8(imagens{i,1})); % hist img original
    title(horzcat('Hist. ', titulos{1,1}));
    
    %%%%%%%% mais contraste
    subplot(2,3,2);
    imshow(uint8(imagens{i,4})); % img mais contraste
    titulo = horzcat(titulos{1,1},sprintf(" med = %d",round(medias(i,4))));
    title(titulo)
    
    subplot(2,3,5);
    imhist(uint8(imagens{i,4})); % hist img mais contraste
    title(horzcat('Hist. ', titulos{1,4}));
    
    %%%%%%% menos contraste
    subplot(2,3,3);
    imshow(uint8(imagens{i,5})); % img menos contraste
    titulo = horzcat(titulos{1,1},sprintf(" med = %d",round(medias(i,5))));
    title(titulo)
    
    subplot(2,3,6);
    imhist(uint8(imagens{i,5})); % hist img menos contraste
    title(horzcat('Hist. ', titulos{1,5}));
    
    filename = horzcat(sprintf('../resultados/brilho_contraste/constraste-im-%i',i),'.png');
    disp(filename)
    saveas(figura_constraste,filename);
    
end
close all;
clear i j titulos medias filename i figura_brilho figura_contraste fatores titulo;
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Equalizacao de histograma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function equalizacao(imagens)
for i=1:2
    im_in = imagens{i,1};
    im_copia = im_in;
    im_copia(im_in==0)=NaN;
    im_eq_copia = histeq(im_copia);
    
    figure
    % EQUALIZACAO
    % Imagem original
    subplot(2,2,1);
    imshow(im_in);
    title('Original');
    
    subplot(2,2,3);
    imhist(im_in);
    title('Histogram');
    
    % Imagem equalizada com preto modificado
    subplot(2,2,2);
    imshow(im_eq_copia);
    title('Equalizada');
    
    subplot(2,2,4);
    imhist(im_eq_copia);
    title('Hist. equal.');
    
    filename = horzcat(sprintf('../resultados/equalizacao/equalizacao-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename);
    
    close all;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funcoes de transformacao de intensidade
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function transformacao_intensidade(imagens)

for i=1:2
    im_in  = imagens{i,1};
    
    r = 0:255;
    
    %negativo
    figure
    s( 1 + r ) = 255 - r;
    im_out = s ( im_in + 1);
    %show imagem original
    subplot(1,3,1);
    imshow(mat2gray(im_in));
    title("Original");
    %show plot de funcao
    subplot( 1, 3, 2 );
    plot( r , s );
    axis( [ 0, 255, 0, 255 ] );
    title("Fun��o Negativo");
    xlabel('r');
    ylabel('s(r)');
    %show imagem processada
    subplot( 1, 3, 3 );
    imshow( mat2gray( im_out ) );
    title("Processada");
    
    filename = horzcat(sprintf('../resultados/transformacao_intensidade/negativo-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename);
    
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    
    %identidade
    s( 1 + r ) = r;
    im_out = s ( im_in + 1);
    %show imagem original
    subplot(1,3,1);
    imshow(mat2gray(im_in));
    title("Original");
    %show plot de funcao
    subplot( 1, 3, 2 ); plot( r , s );
    axis( [ 0, 255, 0, 255 ] );
    title("Fun��o Identidade");
    xlabel('r');
    ylabel('s(r)');
    %show imagem processada
    subplot( 1, 3, 3 );
    imshow( mat2gray( im_out ) );
    title("Processada");
    
    filename = horzcat(sprintf('../resultados/transformacao_intensidade/identidade-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    
    %logaritmica
    figure
    factor = 5;
    s( 1 + r ) = ( 255 / log( 1 + 255 / factor ) ) * log( 1 + r / factor );
    im_out = s ( im_in + 1);
    %show imagem original
    subplot(1,3,1);
    imshow(mat2gray(im_in));
    title("Original");
    %show plot de funcao
    subplot( 1, 3, 2 ); plot( r , s );
    axis( [ 0, 255, 0, 255 ] );
    titulo = sprintf('Fun��o Log. (fator %d)',factor);
    title(titulo);
    xlabel('r');
    ylabel('s(r)');
    %show imagem processada
    subplot( 1, 3, 3 );
    imshow( mat2gray( im_out ) );
    title("Processada");
    
    filename = horzcat(sprintf('../resultados/transformacao_intensidade/log-im-%i-fator-%i',i,factor),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    
    %exponencial
    figure
    factor = 15;
    s( 1 + r ) = ( 255 / ( exp( 255 / factor ) - 1 ) ) * ( exp( r / factor ) - 1 );
    im_out = s ( im_in + 1);
    %show imagem original
    subplot(1,3,1);
    imshow(mat2gray(im_in));
    title('Original');
    %show plot de funcao
    subplot( 1, 3, 2 ); plot( r , s );
    axis( [ 0, 255, 0, 255 ] );
    titulo = sprintf('Fun��o Exp. (fator %d)',factor);
    title(titulo);
    xlabel('r');
    ylabel('s(r)');
    %show imagem processada
    subplot( 1, 3, 3 );
    imshow( mat2gray( im_out ) );
    title("Processada");
    
    filename = horzcat(sprintf('../resultados/transformacao_intensidade/exp-im-%i-fator-%i',i,factor),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    
    %potencia
    figure
    factor = 10;
    s( 1 + r ) = ( 255 / ( 255 .^ factor ) ) * ( r .^ factor );
    s( 1 + r ) = r;
    im_out = s ( im_in + 1);
    %show imagem original
    subplot(1,3,1);
    imshow(mat2gray(im_in));
    title('Original');
    subplot( 1, 3, 2 ); plot( r , s );
    axis( [ 0, 255, 0, 255 ] );
    titulo = sprintf('Fun��o Pot. (fator %d)',factor);
    title(titulo);    %show plot de funcao    xlabel('r');
    ylabel('s(r)');
    %show imagem processada
    subplot( 1, 3, 3 );
    imshow( mat2gray( im_out ) );
    title("Processada");
    
    filename = horzcat(sprintf('../resultados/transformacao_intensidade/potencia-im-%i-fator-%i',i,factor),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    %por faixas
    figure
    r0 = 0 ; s0 = 0;
    r1 = 10 ; s1 = 10;
    r2 = 50; s2 = 53;
    r3 = 255; s3 = 255;
    
    r = r0:r1;
    a = ( s1 - s0 ) / ( r1 - r0 );
    b = s0 - a * r0;
    s ( 1 + r ) = a * r + b;
    
    r = r1+1:r2;
    a = ( s2 - s1 ) / ( r2 - r1 );
    b = s1 - a * r1;
    s ( 1 + r ) = a * r + b;
    
    r = r2+1:r3;
    a = ( s3 - s2 ) / ( r3 - r2 );
    b = s2 - a * r2;
    s ( 1 + r ) = a * r + b;
    
    r = 0:255;
    
    im_out = s ( im_in + 1);
    %show imagem original
    subplot(1,3,1);
    imshow(mat2gray(im_in));
    title("Original");
    %show plot de funcao
    subplot( 1, 3, 2 ); plot( r , s );
    axis( [ 0, 255, 0, 255 ] );
    titulo = sprintf('Faixas r[%d,%d,%d,%d] e s[%d,%d,%d,%d]',r0,r1,r2,r3,s0,s1,s2,s3);
    title(titulo);
    xlabel('r');
    ylabel('s(r)');
    %show imagem processada
    subplot( 1, 3, 3 );
    imshow( mat2gray( im_out ) );
    title("Processada");
    
    filename = horzcat(sprintf('../resultados/transformacao_intensidade/faixas-im-%i-faixa-1',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    %---------------------------------------------------------------------
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtro de suavizacao (borda...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function filtro_suavizacao(imagens)

% Passa baixa
for i=1:2
    
    im_in = imagens{i,1};
    
    % Media 3x3
    media3 = fspecial('average',3);
    imagem_media3 = imfilter(im_in, media3);
    
    figure;
    subplot(1,2,1);
    imshow(uint8(im_in));
    title('Original')
    
    subplot(1,2,2);
    imshow(uint8(imagem_media3));
    titulo = sprintf('Media 1/9');
    title(titulo);
    
    filename = horzcat(sprintf('../resultados/suavizacao/media33-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    % Media 7x7
    media7 = fspecial('average',7);
    imagem_media7 = imfilter(im_in, media7);
    
    figure;
    subplot(1,2,1);
    imshow(uint8(im_in));
    title('Original')
    
    subplot(1,2,2);
    imshow(uint8(imagem_media7));
    titulo = sprintf('Media 1/7');
    title(titulo);
    
    filename = horzcat(sprintf('../resultados/suavizacao/media77-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    % Mediana
    imagem_mediana3 = medfilt2(im_in); % 3x3 default
    
    figure;
    subplot(1,2,1);
    imshow(uint8(im_in));
    title('Original')
    
    subplot(1,2,2);
    imshow(uint8(imagem_mediana3));
    titulo = sprintf('Mediana 3x3');
    title(titulo);
    
    filename = horzcat(sprintf('../resultados/suavizacao/mediana33-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtros espaciais de realce (laplace, quatro/oito pos/neg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function filtro_espacial(imagens)

for i=1:2
    matriz = imagens{i,1};
    
    filtro_laplace_quatro_negativo =  [0 1 0; 1 -4 1; 0 1 0];
    filtro_laplace_quatro_positivo = [0 -1 0; -1 4 -1; 0 -1 0];
    filtro_laplace_oito_negativo = [1 1 1; 1 -8 1; 1 1 1];
    filtro_laplace_oito_positivo = [-1 -1 -1; -1 8 -1; -1 -1 -1];
    
    out_laplace_quatro_negativo      = imfilter(matriz, filtro_laplace_quatro_negativo);
    out_laplace_quatro_positivo    = imfilter(matriz, filtro_laplace_quatro_positivo);
    out_laplace_oito_negativo     = imfilter(matriz, filtro_laplace_oito_negativo);
    out_laplace_oito_positivo     = imfilter(matriz, filtro_laplace_oito_positivo);
    
    figure
    subplot(1,3,1);
    imshow(uint8(matriz));
    title("matriz");title("Original");
    
    subplot(1,3,2);
    imshow(uint8(out_laplace_quatro_negativo));
    title("Laplace Quatro Negativo");
    
    subplot(1,3,3);
    imshow(uint8(matriz + out_laplace_quatro_negativo));
    title("Res. Laplace Quatro Negativo");
    
    filename = horzcat(sprintf('../resultados/filtro_espacial/flaplace-4-neg-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    %%%
    figure
    subplot(1,3,1);
    imshow(uint8(matriz));
    title("matriz");title("Original");
    
    subplot(1,3,2);
    imshow(uint8(out_laplace_quatro_positivo));
    title("Laplace Quatro Positivo");
    
    subplot(1,3,3);
    imshow(uint8(matriz + out_laplace_quatro_positivo));
    title("Res. Laplace Quatro Positivo");
    
    filename = horzcat(sprintf('../resultados/filtro_espacial/flaplace-4-pos-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    %%%
    
    figure
    subplot(1,3,1);
    imshow(uint8(matriz));
    title("matriz");title("Original");
    
    subplot(1,3,2);
    imshow(uint8(out_laplace_oito_negativo));
    title("Laplace Oito Negativo");
    
    subplot(1,3,3);
    imshow(uint8(matriz + out_laplace_oito_negativo));
    title("Res. Laplace Oito Negativo");
    
    filename = horzcat(sprintf('../resultados/filtro_espacial/flaplace-8-neg-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
    %%%
    
    figure
    subplot(1,3,1);
    imshow(uint8(matriz));
    title("matriz");title("Original");
    
    subplot(1,3,2);
    imshow(uint8(out_laplace_oito_positivo));
    title("Laplace Oito Positivo");
    
    subplot(1,3,3);
    imshow(uint8(matriz + out_laplace_oito_positivo));
    title("Res .Laplace Oito Positivo");
    
    
    filename = horzcat(sprintf('../resultados/filtro_espacial/flaplace-8-pos-im-%i',i),'.png');
    disp(filename)
    saveas(gcf,filename)
    
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtros derivativos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filtros de frequencias
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tecnicas de restauracao
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


