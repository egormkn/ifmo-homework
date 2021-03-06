################################################################################
#                              Метод Монте-Карло                               #
#                         Макаренко Егор, группа M3337                         #
#                                 Вариант №22                                  #
################################################################################

gamma = 0.95;                    # Надёжность

################################## Задание №1 ##################################

disp(["===== Задание №1: =====",
      "Оценить объем части тела {F(x) = f(x_1) + ... + f(x_k) <= c},",
      "заключённой в k-мерном кубе с ребром [0, 1]\n"]);

k = 4;                           # Размерность
c = 0.2;                         # Параметр c
a = 11;                          # Коэффициент a
f = @(x) x .^ a;                 # Функция f(x)

for size = [10^4, 10^6]
    points = rand(size, k);
    values = sum(f(points), 2) <= c;
    answer = mean(values);
    delta  = norminv((1 + gamma) / 2) * std(values) / sqrt(size);
    printf("Размер выборки: %d\n", size);
    printf("Объём: %f\n", answer);
    printf("Доверительный интервал: [%f, %f]\n\n", answer-delta, answer+delta);
endfor

################################## Задание №2 ##################################

disp(["===== Задание №2: =====",
      "Вычислить интеграл \\int_0^\\infty (x+1)^2 * exp(-x/2) dx\n"]);

interval = [0, inf];             # Пределы интегрирования
f = @(x) (x+1) .^ 2 * exp(-x/2); # Подынтегральная функция
                                 # f(x) = g(x) * exp(-lambda * x)
g = @(x) (x+1) .^ 2;             # Множитель экспоненты
lambda = 1/2;                    # Коэффициент в экспоненте

printf("Значение, полученное численными методами: %f\n\n", 
       quad(f, interval(1), interval(2)));

for size = [10^4, 10^6]
    points = exprnd(1.0 / lambda, size, 1);
    values = 1.0 / lambda * g(points);
    answer = mean(values);
    delta  = norminv((1 + gamma) / 2) * std(values) / sqrt(size);
    printf("Размер выборки: %d\n", size);
    printf("Значение интеграла: %f\n", answer);
    printf("Доверительный интервал: [%f, %f]\n\n", answer-delta, answer+delta);
endfor

################################## Задание №3 ##################################

disp(["===== Задание №3: =====",
      "Вычислить интеграл \\int_0^3 \\frac{\\sin(x)}{\\sqrt{1+x}} dx\n"]);

interval = [0, 3];               # Пределы интегрирования
f = @(x) sin(x) ./ sqrt(1 + x);  # Подынтегральная функция

printf("Значение, полученное численными методами: %f\n\n", 
       quad(f, interval(1), interval(2)));
      
for size = [10^4, 10^6]
    points = unifrnd(interval(1), interval(2), size, 1);
    values = (interval(2) - interval(1)) * f(points);
    answer = mean(values);
    delta  = norminv((1 + gamma) / 2) * std(values) / sqrt(size);
    printf("Размер выборки: %d\n", size);
    printf("Значение интеграла: %f\n", answer);
    printf("Доверительный интервал: [%f, %f]\n\n", answer-delta, answer+delta);
endfor

################################# Пример вывода ################################
#
# ===== Задание №1: =====
# Оценить объем части тела {F(x) = f(x_1) + ... + f(x_k) <= c},
# заключённой в k-мерном кубе с ребром [0, 1]
# 
# Размер выборки: 10000
# Объём: 0.518700
# Доверительный интервал: [0.508907, 0.528493]
# 
# Размер выборки: 1000000
# Объём: 0.520840
# Доверительный интервал: [0.519861, 0.521819]
# 
# ===== Задание №2: =====
# Вычислить интеграл \int_0^\infty (x+1)^2 * exp(-x/2) dx
# 
# Значение, полученное численными методами: 26.000000
# 
# Размер выборки: 10000
# Значение интеграла: 26.339639
# Доверительный интервал: [25.478404, 27.200875]
# 
# Размер выборки: 1000000
# Значение интеграла: 25.968338
# Доверительный интервал: [25.884294, 26.052381]
# 
# ===== Задание №3: =====
# Вычислить интеграл \int_0^3 \frac{\sin(x)}{\sqrt{1+x}} dx
# 
# Значение, полученное численными методами: 1.280017
# 
# Размер выборки: 10000
# Значение интеграла: 1.278269
# Доверительный интервал: [1.267614, 1.288925]
# 
# Размер выборки: 1000000
# Значение интеграла: 1.279778
# Доверительный интервал: [1.278711, 1.280845]
#
################################################################################
