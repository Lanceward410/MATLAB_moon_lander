g = -9.81 / 6;
initial_velocity = -15;
initial_position = 150;
final_position = 0;
m = 25000;
final_velocity = -0.5;
stretch = -0.3;
syms a c

delta_x = final_position - initial_position;
accel_total = (final_velocity^2 - initial_velocity^2) / (2 * delta_x);

time_duration = 30;
dt = 0.2;
t = 0:dt:time_duration;

velocity = initial_velocity + accel_total * t;
target_index = find(velocity >= -0.5, 1, 'first');

if isempty(target_index)
    disp('Final velocity of -0.5 m/s not reached within the given time frame.');
    target_index = length(t);
else
    actual_time = t(target_index);
    actual_velocity = velocity(target_index);
    t = t(1:target_index);
    velocity = velocity(1:target_index);
    disp('Time (s)   Velocity (m/s)');
    disp([t' velocity']);
    fprintf('Total Acceleration: %f m/s^2\n\n', accel_total);
    disp(['Final velocity of -0.5 m/s reached at t = ' num2str(actual_time) ' seconds, with a
 velocity of ' num2str(actual_velocity) ' m/s.']);
end

figure;
plot(t, velocity, 'b-');
title('Velocity Over Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
grid on;

disp(' ');
fprintf('Total Acceleration during descent: %f m/s^2\n\n', accel_total);

accel_thrust = accel_total - g;
fprintf('Acceleration due to Thrust during descent: %f m/s^2\n\n', accel_thrust);

thrust_force = accel_thrust * g;
fprintf('Force applied by Thrust during descent: %f N\n\n', thrust_force);

integral_a = int(a, 'b', 0, -0.3);
integral_c = int(c, 'c', -0.5, 0);
equation = integral_a == integral_c;
disp('Equation relating a and c: \n');
disp(equation);
solution_a = solve(equation, a);
fprintf('Solution for acceleration after landing (spring compression = 0.3m): %f \n\n', solution_a);

k = (m * solution_a + m * g) / (4 * stretch);
fprintf('The Spring constant (k) is: %f N*m\n\n', k);