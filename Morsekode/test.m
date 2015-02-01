s = 'leave no stone unturned';

remain = s;

for k = 1:4
   [token, remain] = strtok(remain);
   tess(k)={token}
end