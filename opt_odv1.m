clc
clear all
% Verilen veriler = [x,y]
veri = [55.0 16.2; 27.3 30.5; 33.3 16.9; 56.5 16.0; 11.5 40.2; 14.2 38.4; 13.9 41.3; 19.0 43.9; 33.1 28.3; 43.2 33.9; 28.5 44.2; 6.8 24.6; 37.7 28.0; 37.1 33.1];
[n,p]=size(veri);

% Modeli çözümleme
f=[zeros(1,p) ones(1,2*n)]; % Amaç fonksiyonu katsayıları
Aeq=[ones(n, 1) veri(:,1) eye(n,n) -eye(n,n)]; % Eşitsizlik kısıtları matrisi
beq=[veri(:,2)];
lb=[-inf -inf zeros(1,2*n)]; % Değişken alt sınırları
ub=[inf inf inf*ones(1,2*n)]; % Değişken üst sınırları

[x, fval]=linprog(f,[],[],Aeq,beq,lb, ub); % linprog() fonksiyonu ile çözümleme

% Tahmin edilen parametreler
b0 = x(1);
b1 = x(2);

% Sonuçları ekrana yazdırma
fprintf('Tahmin edilen parametreler:\n');
fprintf('b0 = %.4f\n', b0);
fprintf('b1 = %.4f\n', b1);

% Verileri ve tahmin edilen doğruyu çizme
scatter(veri(:,1), veri(:,2), 'b', 'filled'); % Verileri mavi noktalarla çiz
hold on;

% Tahmin edilen doğruyu çizme
x_range = linspace(min(veri(:,1)), max(veri(:,1)), 100); % Çizgiyi çizeceğimiz x aralığı
y_pred = b0 + b1 * x_range; % Tahmin edilen doğru
plot(x_range, y_pred, 'r', 'LineWidth', 2); % Doğruyu kırmızı çizgiyle çiz

xlabel('Kentleşme Oranı (X)');
ylabel('Doğum Oranı (Y)');
title('Veriler ve Tahmin Edilen Doğru');

legend('Veriler', 'Tahmin Edilen Doğru');
grid on;
hold off;







